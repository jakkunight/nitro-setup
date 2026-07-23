---
type: guide
title: Nix and NixOS Guide
description: An opinionated guide on how to manage Nix and NixOS based systems.
timestamp: 2026-07-22 13:45
tags: [nix, nixos, linux, package manager, flakes]
---

<!--toc:start-->

- [Nix and NixOS Package Management Guide (New CLI)](#nix-and-nixos-package-management-guide-new-cli)
  - [Introduction](#introduction)
  - [Part 0: Enable the experimental features](#part-0-enable-the-experimental-features)
  - [Part 1: Managing Packages with `nix profile`](#part-1-managing-packages-with-nix-profile)
    - [Listing Installed Packages](#listing-installed-packages)
    - [Installing Packages](#installing-packages)
    - [Removing Packages](#removing-packages)
    - [Upgrading Packages](#upgrading-packages)
    - [Profile History and Rollback](#profile-history-and-rollback)
  - [Part 2: Additional Useful Commands](#part-2-additional-useful-commands)
    - [Searching for Packages](#searching-for-packages)
    - [Running a Package Temporarily](#running-a-package-temporarily)
    - [Temporary Shell with Packages](#temporary-shell-with-packages)
    - [Building a Package](#building-a-package)
    - [Interactive REPL](#interactive-repl)
    - [Garbage Collection](#garbage-collection)
  - [Part 3: NixOS Declarative Package Management](#part-3-nixos-declarative-package-management)
    - [Declarative Approach](#declarative-approach)
    - [Applying Changes](#applying-changes)
    - [Imperative vs Declarative](#imperative-vs-declarative)
  - [Part 4: Quick Guide to the Nix Language](#part-4-quick-guide-to-the-nix-language)
    - [Overview](#overview)
    - [Basic Data Types](#basic-data-types)
    - [Functions](#functions)
    - [Let Expressions](#let-expressions)
    - [Recursive Attribute Sets (`rec`)](#recursive-attribute-sets-rec)
    - [Imports](#imports)
    - [With Expression](#with-expression)
    - [If-Then-Else](#if-then-else)
    - [Common Patterns](#common-patterns)
    - [Learning Resources](#learning-resources)
  - [Quick Reference: New CLI vs Old CLI](#quick-reference-new-cli-vs-old-cli)

<!--toc:end-->

# Nix and NixOS Package Management Guide (New CLI)

## Introduction

Nix is a purely functional package manager that aims to make package management
reproducible, declarative and reliable. The modern Nix CLI (often referred to as
the "new CLI" or `nix3`) is the unified interface that replaces older commands
like `nix-env` and `nix-build`. This guide focuses on the new CLI.

> **Note:** Many new-style `nix` commands are still marked as experimental and
> may require enabling experimental features.

## Part 0: Enable the experimental features

To temporarily enable the required features use
`export NIX_CONFIG="experimental-features = nix-command flakes"` before the
commands listed below, or use `--experimental-features 'nix-command flakes'`
after the `nix` command. If you're using NixOS, put this inside your config:

```nix
{ config, pkgs, ... }:
{
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    # Rest of the config...
}
```

Or inside your `~/.config/nix/nix.conf` file, if using Nix without NixOS:

```nix
experimental-features = nix-command flakes
# Rest of the config...
```

---

## Part 1: Managing Packages with `nix profile`

The `nix profile` subcommand manages user package profiles — sets of packages
that can be installed and upgraded independently from each other. It is the
modern replacement for `nix-env`.

### Listing Installed Packages

To see what packages you have installed in your profile:

```bash
nix profile list
```

This shows all packages currently installed in your default profile.

### Installing Packages

To install a package from Nixpkgs:

```bash
nix profile install nixpkgs#hello
```

The syntax `nixpkgs#package` specifies the flake reference.

You can install from a specific branch:

```bash
nix profile install nixpkgs/release-20.09#hello
```

Or from a specific revision:

```bash
nix profile install nixpkgs/d73407e8e6002646acfdef0e39ace088bacc83da#hello
```

To install a specific output of a package (e.g., man pages):

```bash
nix profile install nixpkgs#bash^man
```

Install multiple packages at once:

```bash
nix profile install nixpkgs#hello nixpkgs#cowsay nixpkgs#ripgrep
```

> **Note:** `nix profile install` is an alias for `nix profile add`.

### Removing Packages

Remove a package by name:

```bash
nix profile remove hello
```

Remove a package by its position in the profile list:

```bash
nix profile remove 3
```

Remove a package by attribute path:

```bash
nix profile remove packages.x86_64-linux.hello
```

Remove all packages from the profile:

```bash
nix profile remove --all
```

### Upgrading Packages

Upgrade all packages that were installed using an unlocked flake reference:

```bash
nix profile upgrade '.*'
```

Or with the `--all` flag:

```bash
nix profile upgrade --all
```

Upgrade a specific package by name:

```bash
nix profile upgrade hello
```

### Profile History and Rollback

Nix profiles are versioned, allowing easy rollbacks.

View the history of profile changes:

```bash
nix profile history
```

This shows all versions of a profile.

Roll back to the previous version:

```bash
nix profile rollback
```

Roll back to a specific version (e.g., version 3):

```bash
nix profile rollback --to 3
```

To see the available versions, use `nix profile history` first.

View the difference between profile versions:

```bash
nix profile diff-closures
```

Clean up old profile versions (keep only current):

```bash
nix profile wipe-history
```

---

## Part 2: Additional Useful Commands

### Searching for Packages

Search for packages in Nixpkgs:

```bash
nix search nixpkgs <search-term>
```

For example:

```bash
nix search nixpkgs ripgrep
```

### Running a Package Temporarily

Run a package without installing it permanently:

```bash
nix run nixpkgs#hello
```

### Temporary Shell with Packages

Start a temporary shell with specified packages available:

```bash
nix shell nixpkgs#cowsay
```

### Building a Package

Build a derivation without installing:

```bash
nix build nixpkgs#hello
```

### Interactive REPL

Start an interactive Nix expression evaluator:

```bash
nix repl
```

### Garbage Collection

Remove unused store paths:

```bash
nix store gc
```

---

## Part 3: NixOS Declarative Package Management

NixOS has two distinct styles of package management:

1. **Declarative** — you declare what packages you want in `configuration.nix`
2. **Ad hoc (imperative)** — you install via the CLI

### Declarative Approach

With declarative package management, you specify which packages you want on your
system by setting the `environment.systemPackages` option.

In `/etc/nixos/configuration.nix` or your `flake.nix`:

```nix
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    git
    htop
    ripgrep
    fd
    jq
  ];
}
```

Every time you run `nixos-rebuild`, NixOS ensures that you get a consistent set
of binaries corresponding to your specification.

### Applying Changes

For NixOS:

```bash
sudo nixos-rebuild switch
```

For non-NixOS systems using Home Manager:

```bash
home-manager switch
```

### Imperative vs Declarative

The new CLI (`nix profile`) provides imperative package management at the user
level. Packages installed this way are only available to the given user and do
not change system state.

The declarative approach in NixOS is generally recommended for system-wide
packages as it provides:

- Reproducible configurations
- Easy sharing of configurations
- Atomic upgrades and rollbacks

---

## Part 4: Quick Guide to the Nix Language

### Overview

Nix is a purely functional, lazily evaluated, dynamically typed programming
language. In Nix, everything is an expression — there are no statements. Values
in Nix are immutable.

### Basic Data Types

**Integers and arithmetic:**

```nix
1 + 3        # 4
7 - 4        # 3
3 * 2        # 6
6 / 3        # 2 (note the space after /)
```

> **Note:** Without a space, `6/3` is parsed as a relative path. Use `6/ 3` or
> `builtins.div 6 3`.

**Strings:**

```nix
"Hello, world!"
''
  Multi-line
  strings are
  also supported
''
```

**Booleans:**

```nix
true
false
!true        # false
true && false  # false
true || false  # true
```

**Lists:**

```nix
[ 1 2 3 "hello" ]
```

**Attribute sets (like dictionaries/objects):**

```nix
{ name = "Alice"; age = 30; }
```

Access attributes with dot notation:

```nix
{ name = "Alice"; age = 30; }.name  # "Alice"
```

### Functions

Functions are defined with a colon:

```nix
x: x + 1
```

Call a function by writing the argument after it:

```nix
(x: x + 1) 5  # 6
```

Named function:

```nix
let
  add = x: y: x + y;
in
  add 3 4  # 7
```

### Let Expressions

Bind values to names:

```nix
let
  x = 5;
  y = x + 2;
in
  y * 2  # 14
```

### Recursive Attribute Sets (`rec`)

Allow attributes to reference each other:

```nix
rec {
  a = 1;
  b = a + 1;  # b = 2
}
```

### Imports

Import another Nix file:

```nix
import ./some-file.nix
```

### With Expression

Bring attributes from a set into scope:

```nix
with pkgs; [
  vim
  git
  htop
]
```

### If-Then-Else

```nix
if 5 > 3 then "yes" else "no"  # "yes"
```

### Common Patterns

**Package definition (derivation):**

```nix
{ stdenv, fetchurl }:

stdenv.mkDerivation {
  name = "hello-2.12";
  src = fetchurl {
    url = "https://ftp.gnu.org/gnu/hello/hello-2.12.tar.gz";
    sha256 = "1...";
  };
}
```

**NixOS configuration:**

```nix
{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  networking.hostName = "my-machine";

  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  users.users.alice = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
```

### Learning Resources

- The Nix manual provides a full language reference
- `nix repl` is great for experimenting with the language
- [Nix language basics](https://nix.dev/tutorials/nix-language) is a practical
  tutorial

---

## Quick Reference: New CLI vs Old CLI

| Action      | New CLI (`nix`)                   | Old CLI (`nix-env`)       |
| ----------- | --------------------------------- | ------------------------- |
| Install     | `nix profile install nixpkgs#pkg` | `nix-env -iA nixpkgs.pkg` |
| Remove      | `nix profile remove pkg`          | `nix-env -e pkg`          |
| List        | `nix profile list`                | `nix-env -q`              |
| Upgrade all | `nix profile upgrade '.*'`        | `nix-env -u`              |
| Upgrade pkg | `nix profile upgrade pkg`         | `nix-env -uA nixpkgs.pkg` |
| Rollback    | `nix profile rollback`            | `nix-env --rollback`      |
| Search      | `nix search nixpkgs term`         | `nix-env -qaP term`       |
| Build       | `nix build nixpkgs#pkg`           | `nix-build -A pkg`        |
| Run         | `nix run nixpkgs#pkg`             | (no direct equivalent)    |
| Shell       | `nix shell nixpkgs#pkg`           | `nix-shell -p pkg`        |
| REPL        | `nix repl`                        | `nix-instantiate --eval`  |
