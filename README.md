# NixOS Configuration

This is my NixOS configuration.

## Content

<!--toc:start-->
- [NixOS Configuration](#nixos-configuration)
  - [Content](#content)
  - [What do I want?](#what-do-i-want)
    - [Hosts](#hosts)
    - [Users](#users)
    - [System Modules](#system-modules)
      - [Core system modules](#core-system-modules)
      - [Extra system modules](#extra-system-modules)
    - [System Services](#system-services)
    - [Home Modules](#home-modules)
      - [Core home modules](#core-home-modules)
      - [Extra home modules](#extra-home-modules)
    - [User Services](#user-services)
    - [Home configurations](#home-configurations)
    - [Secrets](#secrets)
<!--toc:end-->

## What do I want?

I want to have a _perfect_ setup. A setup that makes me feel productive and
comfortable. I want to know every piece of my setup. I want to make it **mine**.
For that reason I started using NixOS, because it promised somthing like that.

### Hosts

- nitro
- mcoserver

### Users

- jakku
- nixos
- mco

### System Modules

#### Core system modules

- Hardware
- Boot
- File System/Disk
- Shell
- Development
- Text/Code Editor

#### Extra system modules

- Audio
- Networking tools
- Terminal utils
- Security
- System scripts

### System Services

- CUPS
- GVFS
- Udisks2
- Flatpak
- MPD
- StrongSwan
- Virtualization

### Home Modules

#### Core home modules

- Web browser
- File manager
- App launcher
- Status bar
- Desktop
- Window manager
- Keybindings
- Wallpaper engine
- Multimedia
- Office

#### Extra home modules

- Gaming
- Content creation tools

### User Services

### Home configurations

- Hyprland
- i3
- XFCE

### Secrets

_There's nothing here_
