# NixOS Configuration

This is my NixOS configuration. It is aimed to be as flexible as possible
without sacrificing performance and style.

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
The power to have everything, everywhere, all at once.

## System components

### Disk layout and filesystems

As the [NixOS Wiki](https://wiki.nixos.org) states:

> [!INFO] The only thing that NixOS needs to boot, is a root partition (/), a
> boot partition (/boot) and the Nix Store (/nix).

For this reason, during the installation phase, we have to format and partition
the disk manually. Then NixOS will scan the partitions and will be able to mount
all the needed partitions. I want something more declarative. I want to manage
multiple setups without having to part my disk. Another issue that I faced was
the problem of dual booting with Windows. The process was painful and
complicated. But with this knowlage, I think I can do things easier.

#### Disko

To make things more declarative, I want to use
[Disko](https://github.com/nix-community/disko) which is a project tha aims to
setup your disk layout in a declarative maner. This will allow you to setup your
system everywhere, but there are some drawbacks.

The first issue with this aproach is that Disko will **FORMAT AND ERASE ALL THE
DATA IN YOUR DISK**. This is a challenge for some users who bought laptops or
pre-assembled computers with Windows preinstalled and don't want to uninstall it
for whatever reason they have. This can be addressed by making a backup image of
the Windows system and then restoring it on an empty partition left in the Disko
scheme. It is funny, since the one that used to erase your Linux system was
Windows.

The second drawback is that your NixOS configuration is always tied to the disk
layout. This is true, either using Disko, or just the NixOS config. I've found
this annoying, but now that I know what NixOS expects, I can simply let Disko to
handle this part.

### Hardware and firmware

The drivers comes with the kernel itself, but some drivers must be loaded at
boot. For the firmware, I prefer to enable all the firmware, since I'm looking
for a wide hardware support.
