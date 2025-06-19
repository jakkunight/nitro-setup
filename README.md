# NixOS Setup: A NixOS framework to manage Everything, Everywhere, Everytime

This is the general guide to build reliable, multi-user and multi-host configs
with NixOS.

## Goals

- Making portable setups that can be installed and configured without any
  internet connection.
- Managing multiple users, hosts, modules, home configurations, and secrets from
  the same project.
- To have fun learning more about the Nix ecosystem.

## Principles

- Programs, services and modules are different from their configurations. For
  instance, the program `yazi` can be installed at `host-a`, but being used "as
  it". It only means that a user, via Home-Manager, has to activate a
  configuration for that program, or another host has to make select a
  configuration for it.
- Programs, services, modules and configurations are not tied to any hosts or
  users. This means that every program will be enabled or disabled from the main
  `configuration.nix` and `home.nix` files of each host and user.
- System (host) and Home (user) configurations, programs, services, and modules
  are treated separately.
- Secrets are managed by SOPS-NIX.
- Styling is manged by Stylix.
- Disk layout is managed by Disko.
- Programs, services and modules are treated separately.
- Offline ISO installers will be created by NixOS-Generators. They have to
  include all the available firmware support.
- User programs, modules, services and configurations will be handled by
  Home-Manager.
- There will be a Home-Manager config as "standalone" program (to use
  `home-manager switch`) and a config as NixOS module (to use
  `sudo nixos-rebuild switch`).
- Modules, programs and services are grouped together by purpose for
  convenience.
- Every program, module and service must be toggleable on and off, in order to
  make easy to build new system configurations.
- There's only one module configuration at a time for each user-host pair.
- There's only one program configuration at a time for each user-host pair.
- There's only one service configuration at a time for each user-host pair.

## Adding new stuffs

- To add new modules, use `module/default.nix` instead of `module.nix`.
- To add new programs, use `program/default.nix` instead of `program.nix`.
- To add new services, use `service/default.nix` instead of `service.nix`.
- To add a new configuration for a module, use `module/config.nix`.
- To add a new configuration for a program, use `program/config.nix`.
- To add a new configuration for a service, use `service/config.nix`.
- To add a new

## NOTES

Ahoy!

## Basic project structure

```plaintext
flake.nix
flake.lock
.sops.yaml
users/
    user1/
        default.nix
        home.nix
    ...
hosts/
    host1/
        default.nix
    ...
configurations/
    home/
        services/
            ssh/
                conf1.nix
                conf2.nix
                ...
            ...
        programs/
            conf1.nix
            conf2.nix
            ...
        terminal/
            default.nix
            shell/
                conf1.nix
                conf2.nix
                ...
            prompt/
                conf1.nix
                conf2.nix
                ...
    system/
        services/
            ssh/
                conf1.nix
                conf2.nix
                ...
            ...
        programs/
            btop/
                default.nix
            conf2.nix
            ...
        terminal/
            default.nix
            shell/
                conf1.nix
                conf2.nix
                ...
            prompt/
                conf1.nix
                conf2.nix
                ...
modules/
    home/
        services/
            default.nix
            ...
        programs/
            default.nix
            ...
        terminal/
            default.nix
            shell/
                default.nix
                ...
            prompt/
                default.nix
            ...
    system/
        default.nix
        services/
            default.nix
            ...
        programs/
            default.nix
            ...
        hardware/
            default.nix
            audio/
                default.nix
                ...
            cpu/
                default.nix
                ...
            gpu/
                default.nix
                nvidia/
                    default.nix
                ...
            networking/
                default.nix
                ...
            disk/
                default.nix
                disko/
                    default.nix
    terminal/
        default.nix
        shell/
            default.nix
            ...
        prompt/
            default.nix
        ...
    nix/
        default.nix
    networking/
        default.nix
        ...
```
