# Migration: flake-parts + import-tree (`flake.modules`) -> Den

Status: **in progress**. Baseline commit: `6736edc`.

## Goal

Replace the hand-rolled module registry (`flake.modules.{nixos,homeManager,generic}`)
and the factory helpers under `modules/factories/` with **Den aspects**
(`github:denful/den`), while preserving the *effective* outputs:

- `nixosConfigurations`: `germain`, `germain-offline-installer`, `nitro`, `nitro-offline-installer`
- `homeConfigurations`: `ballade`, `jakku`, `sophie`

Hard requirement for this migration: `nix flake check` passes. Derivation-level
evaluation is **out of scope** (too slow here); the user verifies builds.

## How the current setup works (baseline)

- `flake.nix`: `outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);`
- Every `modules/**/*.nix` is auto-imported (files starting with `_` are skipped).
- Each feature file registers one or more plain modules at
  `flake.modules.nixos.<name>` and/or `flake.modules.homeManager.<name>`
  (plus a `flake.modules.generic.systemConstants`).
- `modules/factories/*.nix` are helper *functions* consumed by hosts/users:
  - `mkHost { name }` = `lib.nixosSystem` with `self.modules.nixos.<name>` + common config.
  - `mkOfflineInstaller { name }` = same host module + installer payload.
  - `mkUser` (uid/isAdmin/network) -> `flake.modules.nixos.<user>` + `flake.modules.homeManager.<user>`.
  - `mkHomeManagerNixosModuleConfiguration` -> `flake.modules.nixos."<user>-home"` (imports HM OS module + `home-manager.users.<user>`).
  - `mkSystemSecrets` -> `flake.modules.nixos."<owner>-system-secrets"`.
  - `mkUserSecrets` -> `flake.modules.homeManager."<owner>-secrets"` (unused).
  - `mkHomeConfiguration` -> `flake.homeConfigurations.<user>` (standalone HM).
  - `simple-no-swap` / `simple-no-swap-luks` disko layout factories -> `flake.modules.nixos.<host>` (per host!).
  - `mkNvidiaPrimeConfig` (in `modules/hardware/nvidia-prime.nix`) -> `flake.modules.nixos.nvidia-prime`.
- Module-level composition uses `imports = with self.modules.nixos; [ ... ]`.

### Facts that drive correctness

- `modules/users/jakku/default.nix` has the HM-NixOS integration **commented out**
  (`# jakku-home`): jakku is a plain OS user on `nitro`/`germain`; its
  `homeManager` config only feeds the standalone `homeConfigurations.jakku`.
- `ballade` / `sophie` import `"<user>-home"` in their `nixos` module, so they get
  host-managed HM. `sophie` is commented out of `germain`.
- `nitro` imports only `jakku`; `germain` imports `ballade` + `jakku`.
- `system-types/1..5` (`1-system-default`...`5-system-desktop`, `systemConstants`)
  are **not referenced by any host/user** — dead code today, converted for completeness.
- `modules/nix/tools/flake-parts/nixpkgs.nix` defines `flake.modules.nixos.nixpkgs`,
  which is also unused; only its `perSystem._module.args.pkgs` matters.
- Themes: `ballade` HM uses `kanagawa-theme`, but `germain` host uses
  `pandora-theme`. Aspect `includes` are **cross-class**, so HM-only feature
  imports must stay class-scoped (see "Decisions").

## Target architecture

- Add input `den.url = "github:denful/den"` and `modules/den.nix` with
  `imports = [ inputs.den.flakeModule ];` (Den is flake-parts compatible).
- One aspect per former module name:
  - `flake.modules.nixos.<X>`      -> `den.aspects.<X>.nixos`
  - `flake.modules.homeManager.<X>`-> `den.aspects.<X>.homeManager`
  - `flake.modules.generic.<X>`    -> `den.aspects.<X>.nixos` (only `systemConstants`)
  - A block `flake.modules = { nixos.${f} = A; homeManager.${f} = B; }`
    becomes two assignments `den.aspects.${f}.nixos = A; den.aspects.${f}.homeManager = B;`
    (they merge into one aspect).
- Module-level composition is translated 1:1, class-scoped:
  `imports = with self.modules.<class>; [ a b (inputs.foo.bar) ]`
  -> `imports = with den.aspects; [ a.<class> b.<class> (inputs.foo.bar) ]`.
  Bare identifiers and quoted names get the `.<class>` suffix; dotted expressions
  (`inputs.*`) and comments are left untouched.
- Hosts:
  ```
  den.hosts.x86_64-linux.nitro.users.jakku = { };            # classes default ["user"]
  den.hosts.x86_64-linux.germain.users.ballade.classes = [ "homeManager" ];
  den.hosts.x86_64-linux.germain.users.jakku = { };
  den.aspects.nitro.includes = [ intel-cpu disk ... nightmare-desktop ];
  den.aspects.nitro.nixos = { ...host-specific... };
  ```
  Users are **removed** from host `imports`/`includes`; declaring a host user makes
  the user aspect's `nixos` reach the host automatically (Den `user` class).
- Offline installers are hosts named `<host>-offline-installer`, whose aspect
  `includes = [ den.aspects.<host> ]` plus installer-specific `nixos` config.
  They declare the same users, so `<host>-offline-installer` keeps its users.
- Standalone homes: `den.homes.x86_64-linux.{ballade,jakku,sophie} = { }`.
  Old `mkHomeConfiguration` extras -> `den.schema.home.includes`:
  `stylix-standalone-hm` (standalone only) + `{ homeManager = { nix.package = pkgs.nix; }; }`.

### Settings (reused, per-host tunables)

- `den.reservedKeys = [ "settings" ];`
- `modules/settings/_settings-type.nix` = the generator from the Den docs
  (leading `_` so import-tree skips it), attached via
  `den.schema.host.imports = [ { options.settings = mkOption { type = import ./settings/_settings-type.nix; default = {}; }; } ]`.
- Reused aspects get settings instead of factory functions:
  - `den.aspects.simple-no-swap.settings.{device,deviceName}` (+ `nixos` body reading
    `host.settings."simple-no-swap"`), included by `germain` and `nitro`.
  - `den.aspects.nvidia-prime.settings.{nvidiaBusId,intelBusId,amdgpuBusId}`,
    included by `nitro`.
- Host-specific values that are **not** reused (hostname, locale, timezone, xkb,
  kernel choice, boot, tlp) stay literal in the host aspect's `nixos` body.

## Decisions & rationale

1. **Class-scoped `imports` for intra-module composition, not aspect `includes`.**
   `includes` is cross-class: including `kanagawa-theme` from a *user* aspect would
   push `kanagawa-theme.nixos` (stylix + kanagawa) onto the host, colliding with the
   host's `pandora-theme`. Class-scoped imports preserve the old behavior exactly.
   Host aspects DO use `includes` for their feature list (host scope has only the
   `nixos` class; host-scope `homeManager` content is inert).
2. **User aspects use `includes` only for features the old `user.nixos` imported.**
   Features imported only by `user.homeManager` are placed in
   `den.aspects.<user>.homeManager.imports = [ den.aspects.X.homeManager ... ]`
   to avoid pushing their `nixos` parts onto the host.
3. **Factories are deleted.** `mkUser`/`mkSystemSecrets`/disko/nvidia logic moves
   into the corresponding aspects. `mkHost` common config moves to `den.default.nixos`
   (stateVersion, nh/git, packages, `environment.etc.nixos-setup`) plus
   `den.batteries.hostname` for `networking.hostName` (which already follows
   `host.hostName`, so the offline installer keeps its `-offline-installer` name).
4. **HM OS-module tuning stays on the hosts that enable HM.**
   `home-manager.{useGlobalPkgs,useUserPackages,backupFileExtension}` in the
   `germain` aspect's `nixos` body (the option path does not exist on hosts without
   an HM user). Den imports the HM OS module and forwards the users itself.
5. **Drop `flake-parts` `home-manager` flakeModule import** (`modules/nix/tools/flake-parts/home-manager.nix`);
   Den's HM integration only needs `inputs.home-manager`. Keeps `flake.homeConfigurations`
   owned by Den. Keep `flake-parts` `modules` import until all `flake.modules` uses are gone.
6. **`modules/lib/helpers.nix`** will be a valid flake-parts module exposing the two
   leftover fragment helpers under `flake.lib.helpers` (import-tree imports it as a
   module, so it cannot be a bare function file). If a helper ends up unused it is
   dropped.

## Inventory (module names)

- former `flake.modules.nixos.*`: 1-system-default, 2-system-essential, 3-system-basic,
  4-system-cli, 5-system-desktop, amd-cpu, andescada, ani-cli, anydesk, asciinema,
  audacity, ballade, ballade-home, ballade-system-secrets, bash, bat, bluetooth, brave,
  btop, cava, cinnamon, clock-rs, colors, core, cosmic, cyberpunk, cyberpunk-theme,
  devenv, discord, disk, dns-over-tls, exfat-progs, eza, fastfetch, foot, gaming,
  germain, ghostty, gimp, gparted, handy, helix, hermes-agent, heroic, hyprland,
  hyprland-nvidia, intel-cpu, jack, jakku, jakku-system-secrets, kanagawa,
  kanagawa-dragon, kanagawa-lotus, kanagawa-theme, kanagawa-wave, kde, kdenlive, kitty,
  krita, latest-kernel, libreoffice, libvirt, liquorix-kernel, llama-cpp, lmms,
  multimedia, multimedia-production, nemo, networking, nightmare-desktop, nitro,
  nix-auth, nixpkgs, nmap, ntfs3g, nushell, nvidia-gpu, nvidia-prime, obs-studio,
  obs-studio-nvidia, ollama, ollama-cuda, ollama-vulkan, opencode, openspec, oracle,
  pandora, pandora-theme, pipewire, podman, presenterm, qutebrowser, rmpc, sakura,
  sakura-theme, scarlett2-firmware, searxng, serpantinum-desktop, serpantinum-shell,
  silent-sddm, slow_network, sophie, sophie-home, sophie-system-secrets, speedtest-rs,
  starship, starship-desktop, starship-theme, steam, stylix, synth-midnight-dark,
  terminal-gadgets, tokyo-night-terminal-dark, tokyonight-theme, uutils-coreutils,
  wireshark, wtype, xanmod-kernel, xfce, yazi, yorha-grub, youtube, zathura, zed,
  zellij, zen-kernel, zoxide, zram, zsh
- former `flake.modules.homeManager.*`: 4-system-cli, 5-system-desktop,
  _nightmare-waybar, ani-cli, asciinema, ashell, audacity, ballade, bash, bat, brave,
  btop, cava, clock-rs, colors, core, cyberpunk, cyberpunk-theme, devenv, discord, eza,
  fastfetch, foot, gaming, ghostty, gimp, helix, heroic, hypridle, hyprland, hyprlock,
  hyprwall, jakku, kanagawa(-dragon/-lotus/-wave), kanagawa-theme, kde, kdenlive,
  kitty, krita, libreoffice, llama-cpp, lmms, mpd, multimedia, nemo, nightmare-desktop,
  nightmare-helix, nightmare-hyprland, nightmare-waybar, nushell, obs-studio,
  obs-studio-nvidia, ollama(-cuda/-vulkan), opencode, openspec, pandora, pandora-theme,
  presenterm, qutebrowser, remmina, rmpc, sakura, sakura-theme, serpantinum-desktop,
  serpantinum-shell, sophie, speedtest-rs, starship, starship-desktop,
  starship-hyprland, starship-quickshell, starship-theme, steam, stylix,
  stylix-standalone-hm, swaync, synth-midnight-dark, terminal-gadgets,
  tokyo-night-terminal-dark, tokyonight-theme, uutils-coreutils, wanderer-fastfetch,
  waybar, wofi, yazi, youtube, zathura, zed, zed-editor, zellij, zen-browser, zoxide, zsh

## Phases / commits

1. `feat(den): add den input and flakeModule entrypoint` — flake.nix input, `modules/den.nix`, lockfile.
2. `feat(den): settings generator and helper fragments` — `den.reservedKeys`, `modules/settings/_settings-type.nix`, `modules/lib/helpers.nix`.
3. `refactor(den): convert feature modules to den aspects` — mechanical `flake.modules.*` -> `den.aspects.*`.
4. `refactor(den): declare hosts/users/homes with den entities` — rewrite `modules/hosts/*`, `modules/users/*`, remove `modules/factories/*`.
5. `chore(den): drop unused flake-parts module registry` — remove `flake-parts/modules.nix`, `home-manager.nix`; `nix fmt`; `nix flake check`.

## Risks / open items

- Offline installers reference `self.nixosConfigurations.<host>` for closure deps;
  Den must publish those before the installer config is forced (same as today).
- `den.schema.home`/`den.default` scope: verify `stylix-standalone-hm` and
  `nix.package` do not leak into host HM users.
- `serpantinum-*`, `starship-*`, `ollama-*` and `system-types/*` are dead/partly
  broken today; they are converted mechanically but remain unused.
- No `python3`; bulk edits use `perl` + explicit scripts, validated with
  `nix-instantiate --parse` per changed file.
