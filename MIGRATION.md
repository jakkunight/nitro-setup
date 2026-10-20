# MIGRATION.md — flake-parts → Den

> **Este archivo NO se commitea.** Es un documento de trabajo para guiar la
> migración.

---

## Tabla de contenidos

1. [Resumen del flake actual](#resumen-del-flake-actual)
2. [Inventario de `flake.modules.nixos.*`](#inventario-de-flakemodulesnixos)
3. [Inventario de `flake.modules.homeManager.*`](#inventario-de-flakemoduleshomemanager)
4. [Inventario de `flake.homeConfigurations.*`](#inventario-de-flakehomeconfigurations)
5. [Inventario de hosts](#inventario-de-hosts)
6. [Inventario de usuarios](#inventario-de-usuarios)
7. [Factories y qué hacen](#factories-y-que-hacen)
8. [Valores hardcodeados por host → settings](#valores-hardcodeados-por-host--settings)
9. [Plan de migración detallado](#plan-de-migración-detallado)

---

## Resumen del flake actual

```nix
# flake.nix (simplificado)
{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    den.url = "github:denful/den";  # ← YA PRESENTE
    # ... muchos más inputs
  };
  outputs = inputs: inputs.flake-parts.lib.mkFlake {
    inherit inputs;
  } (inputs.import-tree ./modules);
}
```

**Mecanismo:** `flake-parts` + `import-tree` que importa recursivamente todos
los `.nix` bajo `./modules` como módulos de flake-parts.

**Entrada Den existente:** `modules/den.nix` ya importa
`inputs.den.flakeModule`.

---

## Inventario de `flake.modules.nixos.*`

### Sistema y configuración base

| Feature              | Archivo                                                      | Clases afectadas           | Notas                                                   |
| -------------------- | ------------------------------------------------------------ | -------------------------- | ------------------------------------------------------- |
| `nixpkgs`            | `modules/nix/tools/flake-parts/nixpkgs.nix`                  | `nixos.nixpkgs`            | Configura pkgs con allowUnfree=true                     |
| `systems`            | `modules/nix/tools/flake-parts/systems.nix`                  | —                          | Solo lista de sistemas                                  |
| `modules`            | `modules/nix/tools/flake-parts/modules.nix`                  | —                          | Importa flakeModules.modules                            |
| `home-manager`       | `modules/nix/tools/flake-parts/home-manager.nix`             | —                          | Importa hm flake module                                 |
| `treefmt-nix`        | `modules/nix/tools/flake-parts/treefmt-nix.nix`              | `nixos.treefmt-nix`        | Configura treefmt                                       |
| `systemConstants`    | `modules/system/settings/systemConstants/default.nix`        | `nixos.systemConstants`    | Opciones genéricas                                      |
| `1-system-default`   | `modules/system/system-types/1-system-default/default.nix`   | `nixos.1-system-default`   | Locale, timeZone, nix flakes                            |
| `2-system-essential` | `modules/system/system-types/2-system-essential/default.nix` | `nixos.2-system-essential` | Importa 1 + pipewire, zram, bluetooth, networking, disk |
| `3-system-basic`     | `modules/system/system-types/3-system-basic/default.nix`     | `nixos.3-system-basic`     | Importa 2 + core, ntfs3g                                |
| `4-system-cli`       | `modules/system/system-types/4-system-cli/default.nix`       | `nixos.4-system-cli`       | Importa 3                                               |
| `5-system-desktop`   | `modules/system/system-types/5-system-desktop/default.nix`   | `nixos.5-system-desktop`   | Importa 4 + stylix, nightmare-desktop                   |

### Hardware

| Feature              | Archivo                                   | Clases afectadas                                  |
| -------------------- | ----------------------------------------- | ------------------------------------------------- |
| `intel-cpu`          | `modules/hardware/intel-cpu.nix`          | `nixos.intel-cpu`                                 |
| `disk`               | `modules/hardware/disk.nix`               | `nixos.disk`                                      |
| `bluetooth`          | `modules/hardware/bluetooth.nix`          | `nixos.bluetooth`                                 |
| `networking`         | `modules/hardware/networking.nix`         | `nixos.networking`                                |
| `pipewire`           | `modules/hardware/pipewire.nix`           | `nixos.pipewire`                                  |
| `nvidia-gpu`         | `modules/hardware/nvidia-gpu.nix`         | `nixos.nvidia-gpu`                                |
| `nvidia-prime`       | `modules/hardware/nvidia-prime.nix`       | **Factory** `mkNvidiaPrimeConfig` (no es feature) |
| `scarlett2-firmware` | `modules/hardware/scarlett2-firmware.nix` | `nixos.scarlett2-firmware`                        |

### Desktop

| Feature             | Archivo                                   | Clases afectadas                                                                    |
| ------------------- | ----------------------------------------- | ----------------------------------------------------------------------------------- |
| `hyprland`          | `modules/desktop/hyprland.nix`            | `nixos.hyprland`, `nixos.hyprland-nvidia`                                           |
| `hypridle`          | `modules/desktop/hypridle.nix`            | — (solo HM)                                                                         |
| `hyprlock`          | `modules/desktop/hyprlock.nix`            | — (solo HM)                                                                         |
| `hyprwall`          | `modules/desktop/hyprwall.nix`            | — (solo HM)                                                                         |
| `silent-sddm`       | `modules/desktop/silent-sddm.nix`         | `nixos.silent-sddm`                                                                 |
| `cosmic`            | `modules/desktop/cosmic.nix`              | `nixos.cosmic`                                                                      |
| `kde`               | `modules/desktop/kde.nix`                 | `nixos.kde`                                                                         |
| `cinnamon`          | `modules/desktop/cinnamon.nix`            | `nixos.cinnamon`                                                                    |
| `xfce`              | `modules/desktop/xfce.nix`                | `nixos.xfce`                                                                        |
| `nightmare-desktop` | `modules/desktop/nightmare/default.nix`   | `nixos.nightmare-desktop` (importa hyprland, hyprland-nvidia, kitty, foot, ghostty) |
| `serpantinum-shell` | `modules/desktop/serpantinum/default.nix` | `nixos.serpantinum-shell`                                                           |
| `starship-desktop`  | `modules/desktop/starship/default.nix`    | `nixos.starship-desktop`                                                            |
| `waybar`            | `modules/desktop/waybar.nix`              | — (solo HM)                                                                         |
| `wofi`              | `modules/desktop/wofi.nix`                | — (solo HM)                                                                         |
| `ashell`            | `modules/desktop/ashell.nix`              | — (solo HM)                                                                         |

### Programas (solo NixOS)

| Feature                 | Archivo                                      | Clases afectadas                                           |
| ----------------------- | -------------------------------------------- | ---------------------------------------------------------- |
| `core`                  | `modules/programs/core.nix`                  | `nixos.core` (importa muchos sub-módulos)                  |
| `gaming`                | `modules/programs/gaming.nix`                | `nixos.gaming`                                             |
| `libvirt`               | `modules/programs/libvirt.nix`               | `nixos.libvirt`                                            |
| `multimedia`            | `modules/programs/multimedia.nix`            | `nixos.multimedia`                                         |
| `multimedia-production` | `modules/programs/multimedia-production.nix` | `nixos.multimedia-production`                              |
| `ani-cli`               | `modules/programs/ani-cli.nix`               | `nixos.ani-cli`                                            |
| `anydesk`               | `modules/programs/anydesk.nix`               | `nixos.anydesk`                                            |
| `asciinema`             | `modules/programs/asciinema.nix`             | `nixos.asciinema`                                          |
| `audacity`              | `modules/programs/audacity.nix`              | `nixos.audacity`                                           |
| `bash`                  | `modules/programs/bash.nix`                  | `nixos.bash`                                               |
| `bat`                   | `modules/programs/bat.nix`                   | `nixos.bat`                                                |
| `brave`                 | `modules/programs/brave.nix`                 | `nixos.brave`                                              |
| `btop`                  | `modules/programs/btop.nix`                  | `nixos.btop`                                               |
| `cava`                  | `modules/programs/cava.nix`                  | `nixos.cava`                                               |
| `clock-rs`              | `modules/programs/clock-rs.nix`              | `nixos.clock-rs`                                           |
| `devenv`                | `modules/programs/devenv.nix`                | `nixos.devenv`                                             |
| `discord`               | `modules/programs/discord.nix`               | `nixos.discord`                                            |
| `exfat-progs`           | `modules/programs/exfat-progs.nix`           | `nixos.exfat-progs`                                        |
| `eza`                   | `modules/programs/eza.nix`                   | `nixos.eza`                                                |
| `fastfetch`             | `modules/programs/fastfetch.nix`             | `nixos.fastfetch`                                          |
| `foot`                  | `modules/programs/foot.nix`                  | `nixos.foot`                                               |
| `gimp`                  | `modules/programs/gimp.nix`                  | `nixos.gimp`                                               |
| `gparted`               | `modules/programs/gparted.nix`               | `nixos.gparted`                                            |
| `handy`                 | `modules/programs/handy.nix`                 | `nixos.handy`                                              |
| `helix`                 | `modules/programs/helix.nix`                 | `nixos.helix`                                              |
| `heroic`                | `modules/programs/heroic.nix`                | `nixos.heroic`                                             |
| `kdenlive`              | `modules/programs/kdenlive.nix`              | `nixos.kdenlive`                                           |
| `kitty`                 | `modules/programs/kitty.nix`                 | `nixos.kitty`                                              |
| `krita`                 | `modules/programs/krita.nix`                 | `nixos.krita`                                              |
| `libreoffice`           | `modules/programs/libreoffice.nix`           | `nixos.libreoffice`                                        |
| `llama-cpp`             | `modules/programs/llama-cpp.nix`             | `nixos.llama-cpp`                                          |
| `lmms`                  | `modules/programs/lmms.nix`                  | `nixos.lmms`                                               |
| `nemo`                  | `modules/programs/nemo.nix`                  | `nixos.nemo`                                               |
| `nmap`                  | `modules/programs/nmap.nix`                  | `nixos.nmap`                                               |
| `ntfs3g`                | `modules/programs/ntfs3g.nix`                | `nixos.ntfs3g`                                             |
| `nushell`               | `modules/programs/nushell.nix`               | `nixos.nushell`                                            |
| `obs-studio`            | `modules/programs/obs-studio.nix`            | `nixos.obs-studio`, `nixos.obs-studio-nvidia`              |
| `ollama`                | `modules/programs/ollama.nix`                | `nixos.ollama`, `nixos.ollama-cuda`, `nixos.ollama-vulkan` |
| `opencode`              | `modules/programs/opencode.nix`              | `nixos.opencode`                                           |
| `openspec`              | `modules/programs/openspec.nix`              | `nixos.openspec`                                           |
| `presenterm`            | `modules/programs/presenterm.nix`            | `nixos.presenterm`                                         |
| `qutebrowser`           | `modules/programs/qutebrowser.nix`           | `nixos.qutebrowser`                                        |
| `rmpc`                  | `modules/programs/rmpc.nix`                  | `nixos.rmpc`                                               |
| `speedtest-rs`          | `modules/programs/speedtest-rs.nix`          | `nixos.speedtest-rs`                                       |
| `starship`              | `modules/programs/starship.nix`              | `nixos.starship`                                           |
| `steam`                 | `modules/programs/steam.nix`                 | `nixos.steam`                                              |
| `terminal-gadgets`      | `modules/programs/terminal-gadgets.nix`      | `nixos.terminal-gadgets`                                   |
| `uutils-coreutils`      | `modules/programs/uutils-coreutils.nix`      | `nixos.uutils-coreutils`                                   |
| `wireshark`             | `modules/programs/wireshark.nix`             | `nixos.wireshark`                                          |
| `wtype`                 | `modules/programs/wtype.nix`                 | `nixos.wtype`                                              |
| `yazi`                  | `modules/programs/yazi.nix`                  | `nixos.yazi`                                               |
| `youtube`               | `modules/programs/youtube.nix`               | `nixos.youtube`                                            |
| `zathura`               | `modules/programs/zathura.nix`               | `nixos.zathura`                                            |
| `zed`                   | `modules/programs/zed.nix`                   | `nixos.zed`                                                |
| `zellij`                | `modules/programs/zellij.nix`                | `nixos.zellij`                                             |
| `zoxide`                | `modules/programs/zoxide.nix`                | `nixos.zoxide`                                             |
| `zsh`                   | `modules/programs/zsh.nix`                   | `nixos.zsh`                                                |

### Servicios (solo NixOS)

| Feature        | Archivo                             | Clases afectadas     |
| -------------- | ----------------------------------- | -------------------- |
| `andescada`    | `modules/services/andescada.nix`    | `nixos.andescada`    |
| `dns-over-tls` | `modules/services/dns-over-tls.nix` | `nixos.dns-over-tls` |
| `hermes-agent` | `modules/services/hermes-agent.nix` | `nixos.hermes-agent` |
| `jack`         | `modules/services/jack.nix`         | `nixos.jack`         |
| `nix-auth`     | `modules/services/nix-auth.nix`     | `nixos.nix-auth`     |
| `oracle`       | `modules/services/oracle.nix`       | `nixos.oracle`       |
| `podman`       | `modules/services/podman.nix`       | `nixos.podman`       |
| `searxng`      | `modules/services/searxng.nix`      | `nixos.searxng`      |
| `zram`         | `modules/services/zram.nix`         | `nixos.zram`         |

### Themes

| Feature                     | Archivo                                                    | Clases afectadas                  |
| --------------------------- | ---------------------------------------------------------- | --------------------------------- |
| `stylix`                    | `modules/themes/stylix.nix`                                | `nixos.stylix`                    |
| `cyberpunk-theme`           | `modules/themes/cyberpunk-theme.nix`                       | `nixos.cyberpunk-theme`           |
| `kanagawa-theme`            | `modules/themes/kanagawa-theme.nix`                        | `nixos.kanagawa-theme`            |
| `pandora-theme`             | `modules/themes/pandora-theme.nix`                         | `nixos.pandora-theme`             |
| `sakura-theme`              | `modules/themes/sakura-theme.nix`                          | `nixos.sakura-theme`              |
| `starship-theme`            | `modules/themes/starship-theme.nix`                        | `nixos.starship-theme`            |
| `tokyonight-theme`          | `modules/themes/tokyonight-theme.nix`                      | `nixos.tokyonight-theme`          |
| `colors`                    | `modules/themes/colorschemes/colors.nix`                   | `nixos.colors`                    |
| `cyberpunk`                 | `modules/themes/colorschemes/cyberpunk.nix`                | `nixos.cyberpunk`                 |
| `kanagawa`                  | `modules/themes/colorschemes/kanagawa.nix`                 | `nixos.kanagawa`                  |
| `kanagawa-dragon`           | `modules/themes/colorschemes/kanagawa-dragon.nix`          | `nixos.kanagawa-dragon`           |
| `kanagawa-lotus`            | `modules/themes/colorschemes/kanagawa-lotus.nix`           | `nixos.kanagawa-lotus`            |
| `kanagawa-wave`             | `modules/themes/colorschemes/kanagawa-wave.nix`            | `nixos.kanagawa-wave`             |
| `pandora`                   | `modules/themes/colorschemes/pandora.nix`                  | `nixos.pandora`                   |
| `sakura`                    | `modules/themes/colorschemes/sakura.nix`                   | `nixos.sakura`                    |
| `synth-midnight-dark`       | `modules/themes/colorschemes/synth-midnight-dark.nix`      | `nixos.synth-midnight-dark`       |
| `tokyo-night-terminal-dark` | `modules/themes/colorschemes/tokyonight-terminal-dark.nix` | `nixos.tokyo-night-terminal-dark` |

### Kernels (solo NixOS)

| Feature           | Archivo                                       | Clases afectadas        |
| ----------------- | --------------------------------------------- | ----------------------- |
| `latest-kernel`   | `modules/system/settings/latest-kernel.nix`   | `nixos.latest-kernel`   |
| `liquorix-kernel` | `modules/system/settings/liquorix-kernel.nix` | `nixos.liquorix-kernel` |
| `xanmod-kernel`   | `modules/system/settings/xanmod-kernel.nix`   | `nixos.xanmod-kernel`   |
| `zen-kernel`      | `modules/system/settings/zen-kernel.nix`      | `nixos.zen-kernel`      |
| `slow_network`    | `modules/system/settings/slow-network.nix`    | `nixos.slow_network`    |
| `yorha-grub`      | `modules/system/settings/yorha-grub.nix`      | `nixos.yorha-grub`      |

---

## Inventario de `flake.modules.homeManager.*`

### Desktop HM

| Feature               | Archivo                                                   | Clases afectadas         |
| --------------------- | --------------------------------------------------------- | ------------------------ |
| `hyprland`            | `modules/desktop/hyprland.nix`                            | `hm.hyprland`            |
| `hypridle`            | `modules/desktop/hypridle.nix`                            | `hm.hypridle`            |
| `hyprlock`            | `modules/desktop/hyprlock.nix`                            | `hm.hyprlock`            |
| `hyprwall`            | `modules/desktop/hyprwall.nix`                            | `hm.hyprwall`            |
| `waybar`              | `modules/desktop/waybar.nix`                              | `hm.waybar`              |
| `wofi`                | `modules/desktop/wofi.nix`                                | `hm.wofi`                |
| `ashell`              | `modules/desktop/ashell.nix`                              | `hm.ashell`              |
| `nightmare-hyprland`  | `modules/desktop/nightmare/hyprland/default.nix`          | `hm.nightmare-hyprland`  |
| `nightmare-waybar`    | `modules/desktop/nightmare/waybar/default.nix` + subfiles | `hm.nightmare-waybar`    |
| `serpantinum-shell`   | `modules/desktop/serpantinum/default.nix`                 | `hm.serpantinum-shell`   |
| `starship-hyprland`   | `modules/desktop/starship/hyprland/default.nix`           | `hm.starship-hyprland`   |
| `starship-quickshell` | `modules/desktop/starship/quickshell/default.nix`         | `hm.starship-quickshell` |
| `starship-desktop`    | `modules/desktop/starship/default.nix`                    | `hm.starship-desktop`    |
| `remmina`             | `modules/services/remmina.nix`                            | `hm.remmina`             |
| `swaync`              | `modules/services/swaync.nix`                             | `hm.swaync`              |

### HM Programs

| Feature              | Archivo                                   | Clases afectadas        |
| -------------------- | ----------------------------------------- | ----------------------- |
| `core`               | `modules/programs/core.nix`               | `hm.core`               |
| `gaming`             | `modules/programs/gaming.nix`             | `hm.gaming`             |
| `ani-cli`            | `modules/programs/ani-cli.nix`            | `hm.ani-cli`            |
| `asciinema`          | `modules/programs/asciinema.nix`          | `hm.asciinema`          |
| `audacity`           | `modules/programs/audacity.nix`           | `hm.audacity`           |
| `bash`               | `modules/programs/bash.nix`               | `hm.bash`               |
| `bat`                | `modules/programs/bat.nix`                | `hm.bat`                |
| `brave`              | `modules/programs/brave.nix`              | `hm.brave`              |
| `btop`               | `modules/programs/btop.nix`               | `hm.btop`               |
| `cava`               | `modules/programs/cava.nix`               | `hm.cava`               |
| `clock-rs`           | `modules/programs/clock-rs.nix`           | `hm.clock-rs`           |
| `devenv`             | `modules/programs/devenv.nix`             | `hm.devenv`             |
| `discord`            | `modules/programs/discord.nix`            | `hm.discord`            |
| `eza`                | `modules/programs/eza.nix`                | `hm.eza`                |
| `fastfetch`          | `modules/programs/fastfetch.nix`          | `hm.fastfetch`          |
| `foot`               | `modules/programs/foot.nix`               | `hm.foot`               |
| `gimp`               | `modules/programs/gimp.nix`               | `hm.gimp`               |
| `helix`              | `modules/programs/helix.nix`              | `hm.helix`              |
| `heroic`             | `modules/programs/heroic.nix`             | `hm.heroic`             |
| `kdenlive`           | `modules/programs/kdenlive.nix`           | `hm.kdenlive`           |
| `kitty`              | `modules/programs/kitty.nix`              | `hm.kitty`              |
| `krita`              | `modules/programs/krita.nix`              | `hm.krita`              |
| `libreoffice`        | `modules/programs/libreoffice.nix`        | `hm.libreoffice`        |
| `llama-cpp`          | `modules/programs/llama-cpp.nix`          | `hm.llama-cpp`          |
| `lmms`               | `modules/programs/lmms.nix`               | `hm.lmms`               |
| `mpd`                | `modules/programs/mpd.nix`                | `hm.mpd`                |
| `multimedia`         | `modules/programs/multimedia.nix`         | `hm.multimedia`         |
| `nemo`               | `modules/programs/nemo.nix`               | `hm.nemo`               |
| `nightmare-helix`    | `modules/programs/nightmare-helix.nix`    | `hm.nightmare-helix`    |
| `opencode`           | `modules/programs/opencode.nix`           | `hm.opencode`           |
| `openspec`           | `modules/programs/openspec.nix`           | `hm.openspec`           |
| `presenterm`         | `modules/programs/presenterm.nix`         | `hm.presenterm`         |
| `qutebrowser`        | `modules/programs/qutebrowser.nix`        | `hm.qutebrowser`        |
| `rmpc`               | `modules/programs/rmpc.nix`               | `hm.rmpc`               |
| `speedtest-rs`       | `modules/programs/speedtest-rs.nix`       | `hm.speedtest-rs`       |
| `starship`           | `modules/programs/starship.nix`           | `hm.starship`           |
| `steam`              | `modules/programs/steam.nix`              | `hm.steam`              |
| `terminal-gadgets`   | `modules/programs/terminal-gadgets.nix`   | `hm.terminal-gadgets`   |
| `uutils-coreutils`   | `modules/programs/uutils-coreutils.nix`   | `hm.uutils-coreutils`   |
| `wanderer-fastfetch` | `modules/programs/wanderer-fastfetch.nix` | `hm.wanderer-fastfetch` |
| `yazi`               | `modules/programs/yazi.nix`               | `hm.yazi`               |
| `youtube`            | `modules/programs/youtube.nix`            | `hm.youtube`            |
| `zathura`            | `modules/programs/zathura.nix`            | `hm.zathura`            |
| `zed-editor`         | `modules/programs/zed-editor.nix`         | `hm.zed-editor`         |
| `zed`                | `modules/programs/zed.nix`                | `hm.zed`                |
| `zellij`             | `modules/programs/zellij.nix`             | `hm.zellij`             |
| `zen-browser`        | `modules/programs/zen-browser.nix`        | `hm.zen-browser`        |
| `zoxide`             | `modules/programs/zoxide.nix`             | `hm.zoxide`             |
| `zsh`                | `modules/programs/zsh.nix`                | `hm.zsh`                |

### HM Themes

| Feature                     | Archivo                                                    | Clases afectadas               |
| --------------------------- | ---------------------------------------------------------- | ------------------------------ |
| `stylix`                    | `modules/themes/stylix.nix`                                | `hm.stylix`                    |
| `stylix-standalone-hm`      | `modules/themes/stylix-standalone-hm.nix`                  | `hm.stylix-standalone-hm`      |
| `cyberpunk-theme`           | `modules/themes/cyberpunk-theme.nix`                       | `hm.cyberpunk-theme`           |
| `kanagawa-theme`            | `modules/themes/kanagawa-theme.nix`                        | `hm.kanagawa-theme`            |
| `pandora-theme`             | `modules/themes/pandora-theme.nix`                         | `hm.pandora-theme`             |
| `sakura-theme`              | `modules/themes/sakura-theme.nix`                          | `hm.sakura-theme`              |
| `starship-theme`            | `modules/themes/starship-theme.nix`                        | `hm.starship-theme`            |
| `tokyonight-theme`          | `modules/themes/tokyonight-theme.nix`                      | `hm.tokyonight-theme`          |
| `colors`                    | `modules/themes/colorschemes/colors.nix`                   | `hm.colors`                    |
| `cyberpunk`                 | `modules/themes/colorschemes/cyberpunk.nix`                | `hm.cyberpunk`                 |
| `kanagawa`                  | `modules/themes/colorschemes/kanagawa.nix`                 | `hm.kanagawa`                  |
| `kanagawa-dragon`           | `modules/themes/colorschemes/kanagawa-dragon.nix`          | `hm.kanagawa-dragon`           |
| `kanagawa-lotus`            | `modules/themes/colorschemes/kanagawa-lotus.nix`           | `hm.kanagawa-lotus`            |
| `kanagawa-wave`             | `modules/themes/colorschemes/kanagawa-wave.nix`            | `hm.kanagawa-wave`             |
| `pandora`                   | `modules/themes/colorschemes/pandora.nix`                  | `hm.pandora`                   |
| `sakura`                    | `modules/themes/colorschemes/sakura.nix`                   | `hm.sakura`                    |
| `synth-midnight-dark`       | `modules/themes/colorschemes/synth-midnight-dark.nix`      | `hm.synth-midnight-dark`       |
| `tokyo-night-terminal-dark` | `modules/themes/colorschemes/tokyonight-terminal-dark.nix` | `hm.tokyo-night-terminal-dark` |

### HM System Types

| Feature            | Archivo                                                    | Clases afectadas      |
| ------------------ | ---------------------------------------------------------- | --------------------- |
| `4-system-cli`     | `modules/system/system-types/4-system-cli/default.nix`     | `hm.4-system-cli`     |
| `5-system-desktop` | `modules/system/system-types/5-system-desktop/default.nix` | `hm.5-system-desktop` |

---

## Inventario de `flake.homeConfigurations.*`

| User      | Archivo                             | Extra modules          |
| --------- | ----------------------------------- | ---------------------- |
| `jakku`   | `modules/users/jakku/default.nix`   | `stylix-standalone-hm` |
| `ballade` | `modules/users/ballade/default.nix` | `stylix-standalone-hm` |
| `sophie`  | `modules/users/sophie/default.nix`  | `stylix-standalone-hm` |

---

## Inventario de hosts

### nitro

- **Archivo:** `modules/hosts/nitro/default.nix`
- **Factory:** `self.lib.factory.mkHost { name = "nitro"; }`
- **Imports NixOS:** `intel-cpu`, `disk`, `bluetooth`, `networking`,
  `nvidia-gpu`, `nvidia-prime`, `pipewire`, `slow_network`, `yorha-grub`,
  `latest-kernel`, `zram`, `kanagawa-theme`, `silent-sddm`, `nightmare-desktop`,
  `jakku`
- **Config adicional:** `i18n.defaultLocale`, `time.timeZone`,
  `services.xserver.xkb.layout`, `services.libinput.enable`,
  `environment.systemPackages`, `boot.loader.systemd-boot`
- **Factory calls:**
  `mkNvidiaPrimeConfig(intelBusId="PCI:0:2:0", nvidiaBusId="PCI:1:0:0")`,
  `mkSimpleNoSwap(device="/dev/nvme0n1", deviceName="nitro", host="nitro")`
- **Offline installer:** `mkOfflineInstaller { name = "nitro"; }`

### germain

- **Archivo:** `modules/hosts/germain/default.nix`
- **Factory:** `self.lib.factory.mkHost { name = "germain"; }`
- **Imports NixOS:** `intel-cpu`, `disk`, `bluetooth`, `networking`, `pipewire`,
  `slow_network`, `yorha-grub`, `latest-kernel`, `determinate`, `pandora-theme`,
  `silent-sddm`, `nightmare-desktop`, `kde`, `cinnamon`, `ballade`, `jakku`
- **Config adicional:** `i18n.defaultLocale`, `time.timeZone`,
  `services.xserver.xkb.layout`, `services.libinput.enable`,
  `environment.systemPackages`
- **Factory calls:**
  `mkSimpleNoSwap(device="/dev/sda", deviceName="main", host="germain")`
- **Offline installer:** `mkOfflineInstaller { name = "germain"; }`

---

## Inventario de usuarios

### jakku

- **Archivo:** `modules/users/jakku/default.nix`
- **UID:** 1000
- **Admin:** sí
- **Network:** sí
- **NixOS imports:** `core`, `gaming`, `libvirt`, `andescada`, `asciinema`,
  `obs-studio-nvidia`, `podman`, `wireshark`, `multimedia-production`, `devenv`,
  `hermes-agent`, `scarlett2-firmware`, `nmap`, `gparted`, `ntfs3g`,
  `exfat-progs`, `nemo`, `anydesk`, `handy`, `wtype`, `llama-cpp`, `opencode`,
  `openspec`
- **HM imports:** `devenv`, `core`, `kanagawa-theme`, `gaming`,
  `nightmare-desktop`, `swaync`, `kde`, `libreoffice`, `nightmare-helix`,
  `brave`, `asciinema`, `audacity`, `kdenlive`, `krita`, `gimp`,
  `terminal-gadgets`, `wanderer-fastfetch`, `obs-studio-nvidia`, `opencode`,
  `llama-cpp`, `openspec`
- **SOPS:** `jakku-system-secrets` (andescada secrets)
- **Standalone HM:** `stylix-standalone-hm`
- **Extra groups:** `libvirtd`, `podman`, `wireshark`, `jackaudio`, `audio`
- **Shell:** zsh

### ballade

- **Archivo:** `modules/users/ballade/default.nix`
- **UID:** 1001
- **Admin:** sí
- **Network:** sí
- **NixOS imports:** `core`, `gaming`, `libvirt`, `obs-studio`, `ballade-home`
  (home-manager-nixos-module)
- **HM imports:** `core`, `kanagawa-theme`, `gaming`, `nightmare-desktop`,
  `swaync`, `libreoffice`, `nightmare-helix`, `krita`, `kdenlive`
- **SOPS:** ballade secrets
- **Standalone HM:** `stylix-standalone-hm`
- **Extra groups:** `libvirtd`
- **Shell:** zsh

### sophie

- **Archivo:** `modules/users/sophie/default.nix`
- **UID:** 1002
- **Admin:** sí
- **Network:** sí
- **NixOS imports:** `core`, `gaming`, `libvirt`, `sophie-home`
  (home-manager-nixos-module)
- **HM imports:** `core`, `pandora-theme`, `gaming`, `nightmare-desktop`,
  `swaync`, `libreoffice`, `nightmare-helix`, `krita`
- **SOPS:** sophie secrets
- **Standalone HM:** `stylix-standalone-hm`
- **Extra groups:** `libvirtd`
- **Shell:** zsh

---

## Factories y qué hacen

| Factory                                 | Archivo                                           | Descripción                                                                                                         |
| --------------------------------------- | ------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| `mkHost`                                | `modules/factories/hosts.nix`                     | Envuelve `nixpkgs.lib.nixosSystem` con módulos base (hostPlatform, hostName, stateVersion, git, nh, systemPackages) |
| `mkUser`                                | `modules/factories/users.nix`                     | Crea `nixos.<user>` con grupos y usuario, y `homeManager.<user>` con home config                                    |
| `mkHomeConfiguration`                   | `modules/factories/home-configurations.nix`       | Envuelve `home-manager.lib.homeManagerConfiguration`                                                                |
| `mkSystemSecrets`                       | `modules/factories/system-secrets.nix`            | Configura sops-nix para sistema con secrets                                                                         |
| `mkUserSecrets`                         | `modules/factories/user-secrets.nix`              | Configura sops-nix para home-manager con secrets                                                                    |
| `mkOfflineInstaller`                    | `modules/factories/offline-installer.nix`         | Crea configuración de instalador offline con closure                                                                |
| `mkHomeManagerNixosModuleConfiguration` | `modules/factories/home-manager-nixos-module.nix` | Configura home-manager como módulo NixOS (`home-manager.users.<user>`)                                              |
| `mkNvidiaPrimeConfig`                   | `modules/factories/nvidia-prime.nix`              | Configura NVIDIA Prime con prime offload + sync                                                                     |
| `mkSimpleNoSwap`                        | `modules/factories/simple-no-swap.nix`            | Configura disko con GPT + ESP + root (ext4), sin swap                                                               |
| `mkSimpleNoSwapLuks`                    | `modules/factories/simple-no-swap-luks.nix`       | Variante LUKS de mkSimpleNoSwap                                                                                     |

---

## Valores hardcodeados por host → settings

### nitro

| Valor actual                         | Ubicación             | → Setting propuesto                                  |
| ------------------------------------ | --------------------- | ---------------------------------------------------- |
| `intelBusId = "PCI:0:2:0"`           | `mkNvidiaPrimeConfig` | `den.aspects.nvidia-prime.settings.intelBusId`       |
| `nvidiaBusId = "PCI:1:0:0"`          | `mkNvidiaPrimeConfig` | `den.aspects.nvidia-prime.settings.nvidiaBusId`      |
| `device = "/dev/nvme0n1"`            | `mkSimpleNoSwap`      | `den.aspects.disk.settings.device`                   |
| `deviceName = "nitro"`               | `mkSimpleNoSwap`      | `den.aspects.disk.settings.deviceName`               |
| `i18n.defaultLocale = "es_PY.UTF-8"` | host config           | `den.aspects.nitro.settings.defaultLocale`           |
| `time.timeZone = "America/Asuncion"` | host config           | `den.aspects.nitro.settings.timeZone`                |
| `xkb.layout = "latam"`               | host config           | `den.aspects.nitro.settings.xkbLayout`               |
| `configurationLimit = 3`             | host config           | `den.aspects.nitro.settings.boot.configurationLimit` |
| `services.tlp.enable = true`         | host config           | `den.aspects.nitro.settings.tlp.enable`              |
| `services.tlp.pd.enable = true`      | host config           | `den.aspects.nitro.settings.tlp.pd.enable`           |
| Theme: `kanagawa-theme`              | imports               | (ya es un aspecto)                                   |
| Kernel: `latest-kernel`              | imports               | (ya es un aspecto)                                   |
| Grub: `yorha-grub`                   | imports               | (ya es un aspecto)                                   |

### germain

| Valor actual                                           | Ubicación        | → Setting propuesto                          |
| ------------------------------------------------------ | ---------------- | -------------------------------------------- |
| `device = "/dev/sda"`                                  | `mkSimpleNoSwap` | `den.aspects.disk.settings.device`           |
| `deviceName = "main"`                                  | `mkSimpleNoSwap` | `den.aspects.disk.settings.deviceName`       |
| `i18n.defaultLocale = "es_PY.UTF-8"`                   | host config      | `den.aspects.germain.settings.defaultLocale` |
| `time.timeZone = "America/Asuncion"`                   | host config      | `den.aspects.germain.settings.timeZone`      |
| `xkb.layout = "latam"`                                 | host config      | `den.aspects.germain.settings.xkbLayout`     |
| Theme: `pandora-theme`                                 | imports          | (ya es un aspecto)                           |
| Kernel: `latest-kernel`                                | imports          | (ya es un aspecto)                           |
| Grub: `yorha-grub`                                     | imports          | (ya es un aspecto)                           |
| Determinate: `inputs.determinate.nixosModules.default` | imports          | (ya es un módulo externo)                    |

---

## Plan de migración detallado

### Fase 0 — Reconocimiento

✅ Completado.

### Fase 1 — Añadir Den

✅ Completado.

- `modules/den.nix` importa `inputs.den.flakeModule`.
- `den.schema.user.classes = lib.mkDefault [ "homeManager" ]`.
- `den.default` incluye `define-user` y `hostname`, además de defaults de NixOS
  y Home Manager.
- `flake.nix` conserva `flake-parts` + `import-tree` como entrypoint; Den se
  integra como flake module. Esto es intencional: `perSystem`, packages y
  treefmt siguen viviendo en flake-parts.

### Fase 2 — Migrar features a aspectos

✅ Completado.

- Dominios movidos a
  `modules/aspects/{desktop,hardware,programs,services,system,themes}`.
- 137 archivos convertidos de `flake.modules.*` a `den.aspects.*`.
- Los archivos originales se movieron con `git mv` en lugar de duplicarse, para
  evitar doble registro con `import-tree`.
- No quedan marcadores `TODO(den-migration)`.

### Fase 3 — Migrar usuarios

✅ Completado.

- `modules/users/{jakku,ballade,sophie}.nix` definen aspectos de usuario y
  `den.homes`.
- El battery `define-user` provee `users.users.*` y `homeManager.home.*`.
- `ballade` y `sophie` usan Home Manager en el host; `jakku` queda con
  `classes = [ "user" ]`.
- Los secrets de usuario siguen en aspectos `<user>-system-secrets` con
  `sops-nix`.

### Fase 4 — Migrar hosts

✅ Completado.

- `modules/hosts/{nitro,germain}.nix` usan `den.hosts.x86_64-linux.<host>` y
  `den.aspects.<host>`.
- Los offline installers se declaran como hosts Den: `<host>-offline-installer`.
- Los valores específicos de Nvidia Prime y disko se mantienen en el host o en
  helpers; no se introdujo una capa de settings innecesaria.

### Fase 5 — Eliminar factories y código muerto

✅ Completado.

- `modules/factories/` eliminado.
- `nvidia-prime` se inlinó en `modules/hosts/nitro.nix`.
- `mkSimpleNoSwap` → `modules/_lib/disko-simple-no-swap.nix`.
- `mkOfflineInstaller` → `modules/_lib/offline-installer.nix`.
- `modules/_lib/` queda fuera de `import-tree` por la regla de paths con `/_`.

### Fase 6 — Documentación

✅ Completado (sin commit).

- `README.md` actualizado con Den, el layout y el entrypoint.
- Este documento actualizado con el estado final y las respuestas.
- No se hizo commit porque no fue solicitado.

### Verificación

- `nix flake check --verbose --no-build` → `all checks passed!`
- Configs NixOS: `nitro`, `germain`, `nitro-offline-installer`,
  `germain-offline-installer`.
- Home configs: `jakku`, `ballade`, `sophie`.
- Warnings de evaluación existentes que no bloquean: `programs.rofi.font`
  renombrado y opciones de `virtualisation.containers.registries.*` deprecadas.

### Nota técnica

Los imports manuales entre aspectos desenvuelven `__contentValues` antes de
pasarlos a `imports`. Así se evita que metadatos internos de Den (`_`,
`provides`, `__functor`) se interpreten como opciones NixOS.

## Preguntas pendientes — resueltas

1. **mkNvidiaPrimeConfig** — Inlinado en `modules/hosts/nitro.nix`; los bus IDs
   son específicos del host. No se creó un aspecto con settings.
2. **mkSimpleNoSwap** — Convertido en helper
   `modules/_lib/disko-simple-no-swap.nix`.
3. **mkHomeManagerNixosModuleConfiguration** — Reemplazado por el battery
   `home-manager` de Den y las opciones `home-manager.*` en los aspectos NixOS
   de `ballade` y `sophie`; `jakku` no usa HM en host.
4. **andescada / secrets** — Se mantienen los aspectos `<user>-system-secrets`
   con `sops-nix`; `andescada` sigue usando `config.sops.placeholder`.
5. **obs-studio-nvidia** — Se mantiene como variante de aspecto
   (`obs-studio-nvidia`).
6. **nightmare-waybar** — Los archivos (`main`, `side`, `status`, `style`)
   siguen aportando al mismo aspecto; Den los fusiona. Se agruparon las
   definiciones para evitar errores de atributo dinámico duplicado.
7. **starship-quickshell** — QML/JS se mantienen sin cambios; solo cambió el
   wrapper del módulo.
8. **perSystem** — Sigue en flake-parts (packages, treefmt, devShells); Den no
   lo reemplaza.
9. **den.default** — No está vacío: incluye `define-user`, `hostname`, defaults
   de `system.stateVersion`, `home.stateVersion`, `programs.nh`, `programs.git`,
   paquetes base y `environment.etc.nixos-setup.source`.
10. **offline-installer** — Migrado como helper Den y declarado como host en
    cada archivo de host.

## Resumen de counts

| Tipo                                   | Count                                                     |
| -------------------------------------- | --------------------------------------------------------- |
| `flake.modules.nixos.*` features       | ~90                                                       |
| `flake.modules.homeManager.*` features | ~70                                                       |
| Hosts                                  | 2 (nitro, germain)                                        |
| Users                                  | 3 (jakku, ballade, sophie)                                |
| Host configurations (incl. offline)    | 4 (nitro, nitro-offline, germain, germain-offline)        |
| Home configurations                    | 3 (jakku, ballade, sophie)                                |
| Factories                              | 9                                                         |
| Dominios migrados                      | 6 (desktop, hardware, programs, services, system, themes) |

---

_Documento generado para guiar la migración de nitro-setup de flake-parts a
Den._ _NO commitear._
