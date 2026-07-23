---
type: concept
title: Nix Flake
description: Immutable, dependency-addressable project structure. Each flake is a self-contained unit that can be pinned to specific versions.
timestamp: 2026-07-22 14:30
---

# Flake

## What is a Flake?

A **flake** is an immutable, addressable unit of software composition in Nix.

Unlike traditional package managers, flakes provide:

- **Determinism**: Same inputs always produce the same outputs
- **Version pinning**: Pin exact versions with a lock file
- **Dependency addressing**: Reference any flake by URL or path
- **Shareability**: Lock files ensure reproducibility

## Flake Anatomy

```
flake.nix       # Main definition file
flake.lock      # Lock file with pinned versions
```

## Core Components

### 1. Outputs

Outputs define what a flake produces:

```nix
{
  description = "My flake";
  outputs = { self, nixpkgs, ... }: {
    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
  };
}
```

### 2. Inputs

Inputs declare dependencies:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
}
```

### 3. Standard Flake Structure

```nix
{
  description = "A basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    packages.x86_64-linux.default =
      nixpkgs.legacyPackages.x86_64-linux.stdenv.mkDerivation {
        name = "hello";
        builder = "${nixpkgs.legacyPackages.x86_64-linux.bash}/bin/bash";
        system = "x86_64-linux";
      };
  };
}
```

## Common Commands

```bash
# Build a package from a flake
nix build nixpkgs#hello

# Run a package temporarily
nix run nixpkgs#hello

# Start a shell with packages
nix shell nixpkgs#hello

# Search for packages
nix search nixpkgs hello

# Update the lock file
nix flake update

# Usage with `nixos-rebuild`
nixos-rebuild switch --flake /path/to/the/system/flake#my-hostname

# Usage with `home-manager`
home-manager switch --flake /path/to/the/user/flake#my-username
```

## Flakes vs Traditional Nix

| Feature         | Traditional (nix-env) | Flakes                    |
| --------------- | --------------------- | ------------------------- |
| Version pinning | Manual, error-prone   | Built-in via flake.lock   |
| Dependencies    | `import` with paths   | URL-based addressing      |
| Reproducibility | Manual                | Built-in                  |
| Sharing         | Difficult             | Easy via flake references |

## See Also

- [Dendritic Nix Pattern](./dendritic-nix.md)
- [NixOS Guide](./nixos-guide.md)
- [Flake Parts Documentation](https://flake.parts)
