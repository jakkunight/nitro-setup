# Project setup

## Basics

### Basic components

For NixOS, all that you need is:

- The [hardware configuration](https://github.com/fooblahblah/nixos/blob/master/hardware-configuration.nix)
- The disk layout, done with [Disko](https://github.com/nix-community/disko)
- The [bootloader](https://wiki.nixos.org/wiki/Bootloader)(GRUB, Systemd-boot, etc)
- Networking (WPASupplicant, NetworkManager, etc)
- *[OPTIONAL]* [Home-Manager](https://github.com/nix-community/home-manager)

Althoug NixOS comes with nice defaults, the system will miss some tooling to
make the configuration easier. You will likely want to manage the user
config with Home-Manager.

### Basic tools

Here is a list of tools that I found easy to use and configure. I recommend
you to use them to config your system, since they work even on non graphical
environments. The tools include a filemanager, a code editor, a terminal
multiplexer, a version control tool, and even a ricing utility.

#### Code Editor

- [Helix editor](https://helix-editor.com)

#### Filemanager

- [Yazi](https://github.com/sxyazi/yazi)

#### Terminal multiplexer

- [Zellij](https://zellij.dev)
- [Tmux](https://github.com/tmux/tmux/wiki)

#### Ricing

- [Stylix](https://nix-community.github.io/stylix)

#### Control Version (Git)

- [Git](https://git-scm.com)

#### Shells

- [ZSH](https://www.zsh.org)

#### Useful tools

- [NixHelper](https://github.com/nix-community/nh)
- [Zoxide](https://github.com/ajeetdsouza/zoxide)
- [Eza](https://github.com/eza-community/eza)
- [DUA](https://github.com/Byron/dua-cli)

These tools will make your experience with Nix/NixOS much more comfortable.

## Specific tooling

Here is a list with specific tools for different use cases.

### Development

- [Devenv](https://devenv.sh)
- [Devbox](https://www.jetify.com/devbox)
- [Direnv](https://wiki.nixos.org/wiki/Direnv)
- [Docker](https://wiki.nixos.org/wiki/Docker)
- [VS Code](https://wiki.nixos.org/wiki/Visual_Studio_Code)
- [Zed Editor](https://wiki.nixos.org/wiki/Zed)

#### Neovim distros

Since NixOS provides a new way to manage your config and plugins,
there are some Neovim/Vim distros that makes easier to use and
configure your Neovim setup.

- [Vanilla (The default way with Nix/Home-Manager)](https://wiki.nixos.org/wiki/Neovim)
- [NVF](https://notashelf.github.io/nvf/)
- [NixVim](https://nix-community.github.io/nixvim/)

You can manage almost any dev environment that you might need.

### Virtualization

- [VirtManager](https://wiki.nixos.org/wiki/Virt-manager)
- [QEMU](https://wiki.nixos.org/wiki/QEMU)

### Networking

- [Netscanner](https://github.com/Chleba/netscanner)
- [Wireshark](https://www.wireshark.org)
- [NMAP](https://nmap.org)

### Gaming

- [Steam](https://wiki.nixos.org/wiki/Steam)
- [Heroic](https://wiki.nixos.org/wiki/Heroic_Games_Launcher)
- [Bottles](https://wiki.nixos.org/wiki/Bottles)
- [Lutris](https://wiki.nixos.org/wiki/Lutris)

### Security

- [Vulnix](https://github.com/nix-community/vulnix)
- [ClamAV](https://wiki.nixos.org/wiki/Clamav)

For further reference in this topic refer to
[Paranoid NixOS Setup](https://xeiaso.net/blog/paranoid-nixos-2021-07-18/)

### Office

- [ONLYOFFICE](https://wiki.nixos.org/wiki/ONLYOFFICE)
- [LibreOffice](https://wiki.nixos.org/wiki/LibreOffice)
- [TeXLive](https://wiki.nixos.org/wiki/TexLive)

### Art & Content Creation

- [OBS Studio](https://wiki.nixos.org/wiki/OBS_Studio)
- [Krita](https://krita.org/es/)
- [GIMP](https://www.gimp.org/)
- [Kdenlive](https://kdenlive.org/es/)
- [Audacity](https://www.audacityteam.org/#)
- [LMMS](https://lmms.io/)
- [Bitwig Studio](https://www.bitwig.com/)
- [DaVinci Resolve](https://wiki.nixos.org/wiki/DaVinci_Resolve)
