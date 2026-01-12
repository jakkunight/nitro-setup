# My Setup Settings (v0.7.0b)

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
- [x] GPU: NVIDIA GEFORCE RTX 40+ series
- [x] Audio server: PipeWire
- [ ] Keyboard settings: XREMAP

#### Secrets Manager

- [x] SOPS-NIX

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
- [x] DUA
- [x] DU-Dust
- [x] Btop
- [ ] Presenterm
- [x] uutils coreutils
- [x] Ripgrep
- [x] fd
- [x] Bat
- [x] XH
- [x] FSelect
- [x] Delta
- [x] Ripgrep-all
- [x] MProcs

### Development

- [x] Devenv
- [ ] Kondo
- [ ] Hyperfine
- [x] Just
- [x] Mask

### Networking

- [ ] Netscanner
- [x] Wireshark
- [x] nmap

### Security

- [ ] ClamAV
- [ ] Vulnix
