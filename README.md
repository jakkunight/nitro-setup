# My Setup Settings (v0.5.0b)

This is a setup using the good old [`flake-parts`](https://flake.parts/)
framework and the allmighty
[Determinate Nix](https://docs.determinate.systems/determinate-nix/) Nix
distribution.

The idea behind this is to make my config a bit more... declarative, leveraging
the [Dendritic Nix Pattern](https://dendrix.oeiuwq.com/Dendritic.html) since it
does not force a specific directory structure and makes the thinking more in
terms of "features" instead of NixOS modules, HomeManager modules, Darwin
modules, and so.

## Features

### Base

#### Kernel

- [x] Latest (6.18 at 2025-12-17)

#### Hardware

- [ ] CPU: Intel
- [ ] GPU: NVIDIA GEFORCE RTX 40+ series
- [ ] Audio server: PipeWire
- [ ] Keyboard settings: XREMAP

#### Secrets Manager

- [ ] SOPS-NIX

#### Text Editor

- [ ] Helix

#### File Manager

- [ ] Yazi

#### Ricing

- [ ] Stylix

#### Control Version

- [ ] Git
- [ ] Gitui

#### Shell

- [ ] ZSH (Login)
- [ ] Nushell

#### Other tools

- [ ] NixHelper
- [ ] Zoxide
- [ ] Eza
- [ ] DUA
- [ ] DU-Dust
- [ ] Btop
- [ ] Presenterm
- [ ] uutils coreutils
- [ ] Ripgrep
- [ ] fd
- [ ] Bat
- [ ] XH
- [ ] FSelect
- [ ] Delta
- [ ] Ripgrep-all
- [ ] MProcs

### Development

- [ ] Devenv
- [ ] Kondo
- [ ] Hyperfine
- [ ] Just
- [ ] Mask

### Networking

- [ ] Netscanner
- [ ] Wireshark
- [ ] nmap

### Security

- [ ] ClamAV
- [ ] Vulnix
