# My Setup Settings (v0.9.0b)

This is a NixOS configuration built on the [Den](https://github.com/denful/den)
framework, [`flake-parts`](https://flake.parts/), and the allmighty
[Determinate Nix](https://docs.determinate.systems/determinate-nix/) Nix
distribution.

Den provides the entity/aspect model: hosts, users, and standalone home
configurations are declared as entities, while reusable configuration lives in
`den.aspects`. This keeps the config declarative and organized by feature rather
than by module class.

## Layout

- `flake.nix` — inputs and flake-parts entrypoint.
- `modules/den.nix` — Den schema, defaults, and shared aspects.
- `modules/hosts/` — `den.hosts` declarations and offline installers.
- `modules/users/` — user aspects and `den.homes` declarations.
- `modules/aspects/` — reusable feature aspects (`desktop`, `hardware`,
  `programs`, `services`, `system`, `themes`).
- `modules/_lib/` — plain helpers (ignored by `import-tree`).

## Setup goals

- Make the desktop to look as simple as possible, yet simple to use.
- Make an efficient setup with low battery usage.
- Have some fun.

## Main Components

- OS: NixOS (Unstable)
- Home-Manager: Yes
- Shell: Zsh/Nushell
- Prompt: Starship
- WM: Hyprland
- App Launcher/Menu: Wofi
- Lockscreen: Hyprlock
- Wallpaper: Hyprpaper
- Text editor: Helix
- Secondary text editor: Zed
- Web browser: ZenBrowser + Brave
- File manager: Yazi + Nemo
