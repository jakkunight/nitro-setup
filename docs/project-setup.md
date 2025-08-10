# Project setup

## Basics

### Basic components

For NixOS, all that you need is:

- The [hardware-configuration.nix](<>)
- The disk layout, done with [Disko](https://github.com/nix-community/disko)
- The [bootloader](<>)(GRUB, Systemd-boot, etc)
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

- [Helix editor](https://helix-editor.com)
- [NixHelper](https://github.com/nix-community/nh)
- [Yazi](https://github.com/sxyazi/yazi)
- [Zellij](https://zellij.dev)
- [Stylix](https://nix-community.github.io/stylix)
- [Git](https://git-scm.com)
- [Zoxide](https://github.com/ajeetdsouza/zoxide)
- [Eza](https://github.com/eza-community/eza)
- [DUA](https://github.com/Byron/dua-cli)
- [ZSH](https://www.zsh.org)

These tools will make your experience with Nix/NixOS much more comfortable.

## Specific tooling

Here is a list with specific tools for different use cases.

### Development

- [Devenv](https://devenv.sh)
- [Devbox](https://www.jetify.com/devbox)
- [Direnv](https://wiki.nixos.org/wiki/Direnv)
- [Docker](https://wiki.nixos.org/wiki/Docker)

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
