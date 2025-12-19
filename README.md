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

- [x] CPU: Intel
- [ ] GPU: NVIDIA GEFORCE RTX 40+ series
- [x] Audio server: PipeWire
- [ ] Keyboard settings: XREMAP

#### Secrets Manager

- [ ] SOPS-NIX

#### Text Editor

- [x] Helix

#### File Manager

- [x] Yazi

#### Ricing

- [x] Stylix

#### Control Version

- [x] Git
- [x] Gitui

#### Shell

- [x] ZSH (Login)
- [ ] Nushell

#### Other tools

- [x] NixHelper
- [x] Zoxide
- [x] Eza
- [ ] DUA
- [ ] DU-Dust
- [x] Btop
- [ ] Presenterm
- [ ] uutils coreutils
- [ ] Ripgrep
- [ ] fd
- [x] Bat
- [ ] XH
- [ ] FSelect
- [ ] Delta
- [ ] Ripgrep-all
- [ ] MProcs

### Development

- [x] Devenv
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
