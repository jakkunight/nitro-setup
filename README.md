# My Setup Settings (v0.9.0b)

This is a setup using the good old [`flake-parts`](https://flake.parts/)
framework and the allmighty
[Determinate Nix](https://docs.determinate.systems/determinate-nix/) Nix
distribution.

The idea behind this is to make my config a bit more... declarative, leveraging
the [Dendritic Nix Pattern](https://dendrix.oeiuwq.com/Dendritic.html) since it
does not force a specific directory structure and makes the thinking more in
terms of "features" instead of NixOS modules, HomeManager modules, Darwin
modules, and so, while keeping a flexible directory structure.

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
- File manager: Yazi + Nautilus
