---
name: den-aspect-creator
description: Create and manage Den Framework aspects for NixOS, nix-Darwin, and home-manager configurations.
---

# Den Aspect Creator Skill

## Skill Name

**den-aspect-creator**

## Description

A Pi coding agent skill for creating and managing Den Framework aspects for NixOS, nix-Darwin, and home-manager configurations. Aspects are composable configuration units that bundle modules for one or more Nix classes in a single attrset, enabling feature-first, cross-platform configuration.

## Purpose

This skill enables the Pi coding agent to:

- Create well-structured Den aspects that work across NixOS, Darwin, and home-manager
- Compose aspects using `includes` (DAG edges) for dependency management
- Use parametric aspect functions that react to available context (host, user, pkgs, etc.)
- Bundle platform-specific configuration under a single feature umbrella
- Follow Den Framework best practices for aspect organization

## Use Cases

1. **System-level features**: Configure NixOS packages, services, and hardware settings
2. **User-level features**: Configure home-manager applications and dotfiles
3. **Cross-platform features**: Configure the same feature across NixOS, Darwin, and HM simultaneously
4. **Conditional features**: Activate configuration based on host attributes (GPU type, OS, etc.)
5. **Feature composition**: Build complex features from simpler reusable aspects

## Key Den Framework Concepts

### 1. Aspect Structure

An aspect is a function from context to a Nix attrset containing class modules:

```nix
den.aspects.my-feature = { host, user, pkgs, lib, ... }: {
  nixos = { pkgs, ... }: { /* NixOS config */ };
  homeManager = { pkgs, ... }: { /* Home Manager config */ };
  darwin = { pkgs, ... }: { /* nix-darwin config */ };
};
```

### 2. Class Keys

Aspects use class keys to deliver configuration to specific Nix classes:

| Key | Target |
|-----|--------|
| `nixos` | NixOS system configuration |
| `darwin` | nix-darwin system configuration |
| `homeManager` | Home Manager user configuration |
| Custom | Via `den.batteries.forward` |

### 3. Aspect Keys

| Key | Type | Purpose |
|-----|------|---------|
| `<class>` | module / config | Config merged into entities of that class |
| `includes` | `listOf provider` | Providers pulled into this aspect |
| `excludes` | `listOf provider` | Aspects excluded from this subtree |
| `provides` / `_` | submodule | Legacy sub-aspect namespace |
| `policies` | policy registry | Named policy functions |
| `meta` | submodule | Attached metadata |
| `classes` | `lazyAttrsOf raw` | Class schemas declared |
| `name` / `description` | `str` | Aspect name and description |

### 4. Static vs Parametric Includes

- **Static (plain attrset)**: `{ nixos.foo = ...; }` - emitted unconditionally
- **Static (aspect leaf)**: `{class, aspect-chain}: { ${class}.foo = ...; }` - gets class context
- **Parametric (function)**: `{ host, user }: { ${host.class}.foo = ...; }` - deferred per context

### 5. Context-Driven Dispatch

Aspects declare needed context via function parameters. Den's effects pipeline injects the right values:

```nix
den.aspects.my-feature = { host, user, pkgs, lib, ... }: {
  nixos = { pkgs, ... }: {
    networking.hostName = host.name;
  };
};
```

### 6. Cross-Entity Provides

Deliver configuration across entity boundaries:

```nix
den.aspects.my-feature = {
  # Deliver to ALL users on this host
  provides.to-users = { user, ... }: {
    homeManager.programs.helix.enable = true;
  };
  # Deliver to a specific user by name
  provides.alice.homeManager.programs.vim.enable = true;
};
```

### 7. Nested Aspects

Any key on an aspect that is not a class key or structural key is itself an aspect:

```nix
den.aspects.gpu = { host, ... }:
  lib.optionalAttrs (host ? gpu && host.gpu == "nvidia") {
    nixos.hardware.nvidia.enable = true;
  };
```

## Example Nix Code Snippets

### Basic Aspect: Git Configuration

```nix
# Simple aspect with both NixOS and home-manager config
den.aspects.git = {
  nixos = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.git ];
  };
  homeManager = { pkgs, ... }: {
    programs.git.enable = true;
    programs.git.settings.user.name = "Alice";
    programs.git.settings.user.email = "alice@example.com";
  };
};
```

### Conditional Aspect: GPU Configuration

```nix
# Aspect that activates based on host attributes
den.aspects.gpu-config = { host, pkgs, lib, ... }: {
  nixos = lib.mkMerge [
    (lib.mkIf (host ? gpu && host.gpu == "nvidia") {
      hardware.nvidia.enable = true;
      hardware.nvidia.openSupport = false;
    })
    (lib.mkIf (host ? gpu && host.gpu == "amd") {
      hardware.nvidia.enable = false;
      hardware.opengl.enable = true;
    })
  ];
};

# Include on specific hosts
den.aspects.laptop.includes = [ den.aspects.gpu-config ];
```

### Feature Composition with Includes

```nix
# Base aspect
den.aspects.dev-tools = {
  nixos = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.git pkgs.neovim pkgs.vscode pkgs.cargo
    ];
  };
  homeManager = { pkgs, ... }: {
    programs.git.enable = true;
    programs.neovim.enable = true;
    programs.vscode.enable = true;
  };
};

# Composed aspect
den.aspects.workstation = {
  includes = [
    den.aspects.dev-tools
    den.aspects.gaming
  ];
  nixos = { pkgs, ... }: {
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
  };
};
```

### Cross-Platform Feature: Docker

```nix
# Docker aspect works on NixOS, Darwin, and home-manager
den.aspects.docker = {
  nixos = { pkgs, ... }: {
    virtualisation.docker.enable = true;
    virtualisation.docker.daemon = {
      packages = [ pkgs.docker-compose ];
    };
  };
  darwin = { pkgs, ... }: {
    homebrew.casks = [ "docker" ];
  };
  homeManager = { pkgs, ... }: {
    programs.docker-compose.enable = true;
  };
};
```

### Parametric Aspect with User Context

```nix
# Aspect that configures per-user settings
den.aspects.alice-workspace = { user, pkgs, lib, ... }: {
  homeManager = { pkgs, ... }:
    lib.mkIf (user.name == "alice") {
      programs.helix.enable = true;
      programs.helix.settings = {
        theme = "dark";
        statusline.left = [
          "mode"
          "separator"
          "file_name"
          "git_status"
        ];
      };
    };
  nixos = { pkgs, ... }:
    lib.mkIf (user.name == "alice") {
      users.users.alice.extraGroups = [ "docker" ];
    };
};
```

### Aspect with Nested Sub-aspects

```nix
den.aspects.editor = {
  # Sub-aspect: VS Code
  vscode = { pkgs, ... }: {
    homeManager = { pkgs, ... }: {
      programs.vscode.enable = true;
      programs.vscode.profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          dbaeumer.vscode-eslint
          eamodio.gitlens
        ];
      };
    };
  };

  # Sub-aspect: Helix
  helix = { pkgs, ... }: {
    homeManager = { pkgs, ... }: {
      programs.helix.enable = true;
    };
  };
};
```

### Aspect with Settings Pattern

```nix
# Declare settings on the aspect
den.aspects.web-server = {
  settings.port = lib.mkOption {
    type = lib.types.port;
    default = 8080;
  };
  settings.ssl = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  # Use settings in config
  nixos = { host, pkgs, lib, ... }: {
    services.nginx.enable = true;
    services.nginx.virtualHosts."${host.name}.local" = {
      listen = [ "${host.settings.web-server.port}" ];
      ssl = host.settings.web-server.ssl;
    };
  };
};

# Set settings on host
den.hosts.x86_64-linux.webserver.settings.web-server.port = 443;
den.hosts.x86_64-linux.webserver.settings.web-server.ssl = true;
```

### Using den.default for Shared Config

```nix
# Applied to every host, user, and home
den.default = {
  nixos.system.stateVersion = "25.11";
  homeManager.home.stateVersion = "25.11";
  includes = [
    den.batteries.define-user
    den.batteries.hostname
    den.batteries.flake-scope
    den.batteries.inputs'
    den.batteries.self'
  ];
};
```

### Aspect with Quirks Pattern

```nix
# Declare quirk
den.quirks.firewall.description = "Firewall port declarations";

# Aspect emits quirk data
den.aspects.nginx = {
  nixos.services.nginx.enable = true;
  firewall = { ports = [ 80 443 ]; };
};

# Another aspect emits quirk data
den.aspects.postgres = {
  nixos.services.postgresql.enable = true;
  firewall = { ports = [ 5432 ]; };
};

# Consumer aspect receives assembled data
den.aspects.networking = {
  nixos = { firewall, lib, ... }: {
    networking.firewall.allowedTCPPorts =
      lib.concatMap (f: f.ports or []) firewall;
  };
};
```

### Using hasAspect for Conditional Logic

```nix
# Aspect that adapts based on what other aspects are present
den.aspects.impermanence = { host, lib, ... }: {
  nixos = lib.mkMerge [
    (lib.mkIf (host.hasAspect den.aspects.zfs-root) {
      # ZFS-flavored impermanence
      boot.initrd.postDeviceCommands = "zfs-import";
    })
    (lib.mkIf (host.hasAspect den.aspects.btrfs-root) {
      # Btrfs-flavored impermanence
      fileSystems."/persist".neededForRoot = true;
    })
  ];
};
```

## Best Practices

### 1. Keep Aspects Small and Focused

```nix
# Good: Single responsibility
den.aspects.git = {
  nixos = { pkgs, ... }: { environment.systemPackages = [ pkgs.git ]; };
  homeManager = { pkgs, ... }: { programs.git.enable = true; };
};

# Good: Single responsibility
den.aspects.vscode = {
  nixos = { pkgs, ... }: { environment.systemPackages = [ pkgs.vscode ]; };
  homeManager = { pkgs, ... }: { programs.vscode.enable = true; };
};
```

### 2. Use Includes for Dependencies

```nix
den.aspects.workstation = {
  includes = [
    den.aspects.dev-tools
    den.aspects.gaming
    den.batteries.primary-user
  ];
  nixos.services.xserver.enable = true;
};
```

### 3. Leverage den.default for Shared Config

```nix
den.default = {
  nixos.system.stateVersion = "25.11";
  homeManager.home.stateVersion = "25.11";
  includes = [
    den.batteries.define-user
    den.batteries.hostname
    den.batteries.flake-scope
    den.batteries.inputs'
  ];
};
```

### 4. Use Quirks for Cross-Cutting Concerns

```nix
# Declare quirk
den.quirks.firewall.description = "Firewall port declarations";

# Emit from multiple aspects
den.aspects.nginx.firewall = { ports = [ 80 443 ]; };
den.aspects.postgres.firewall = { ports = [ 5432 ]; };

# Consume in a single aspect
den.aspects.networking.nixos = { firewall, lib, ... }: {
  networking.firewall.allowedTCPPorts =
    lib.concatMap (f: f.ports or []) firewall;
};
```

### 5. Use hasAspect for Conditional Logic

```nix
den.aspects.impermanence = { host, ... }: {
  nixos = lib.mkMerge [
    (lib.mkIf (host.hasAspect den.aspects.zfs-root) { /* ZFS config */ })
    (lib.mkIf (host.hasAspect den.aspects.btrfs-root) { /* Btrfs config */ })
  ];
};
```

## Common Mistakes

### 1. Home Manager on Host Aspect

```nix
# WRONG - host scope homeManager has nowhere to go
den.aspects.laptop.homeManager.programs.vim.enable = true;

# RIGHT - use provides.to-users
den.aspects.laptop.provides.to-users.homeManager.programs.vim.enable = true;
```

### 2. Missing Classes for Home Manager

```nix
# WRONG - user doesn't have homeManager class
den.hosts.x86_64-linux.laptop.users.alice = { };

# RIGHT - add homeManager class
den.hosts.x86_64-linux.laptop.users.alice.classes = [ "homeManager" ];
```

### 3. Forgetting to Include Batteries

```nix
# WRONG - users won't be created
den.hosts.x86_64-linux.laptop.users.alice = { };

# RIGHT - include define-user battery
den.default.includes = [ den.batteries.define-user ];
```

## Integration Instructions for Pi Coding Agent

### When to Use This Skill

Use this skill when:
1. Creating a new feature aspect for NixOS, Darwin, or home-manager
2. Refactoring existing NixOS configuration into Den aspects
3. Adding cross-platform configuration (same feature on multiple platforms)
4. Composing complex features from simpler reusable aspects
5. Setting up conditional configuration based on host attributes

### Step-by-Step Workflow

1. **Identify the feature**: What configuration does this aspect provide?
2. **Determine target platforms**: NixOS, Darwin, home-manager, or all?
3. **Define context needs**: What context does the aspect need (host, user, pkgs)?
4. **Create the aspect**: Write the aspect function with class keys
5. **Add includes**: List any dependent aspects
6. **Register on host**: Include the aspect in the host's aspect tree
7. **Test**: Run `nix flake check` to verify

### Quick Reference: Creating an Aspect

```nix
# 1. Define the aspect
den.aspects.<feature-name> = { host, user, pkgs, lib, ... }: {
  # 2. Add class modules as needed
  nixos = { pkgs, ... }: { /* NixOS config */ };
  homeManager = { pkgs, ... }: { /* HM config */ };
  darwin = { pkgs, ... }: { /* Darwin config */ };

  # 3. Add includes for dependencies (optional)
  # includes = [ den.aspects.dependency ];
};

# 4. Include on host(s)
den.aspects.<host-name>.includes = [ den.aspects.<feature-name> ];
```

### When to Create Nested Sub-aspects

Create nested sub-aspects when:
- A feature has multiple mutually exclusive implementations (editor: vscode vs helix)
- You want to organize related configuration hierarchically
- Different sub-features have different context requirements

### Aspect Naming Conventions

- Use kebab-case for aspect names: `den.aspects.git-config`
- Use descriptive names that indicate the feature: `den.aspects.docker`, `den.aspects.gpu-config`
- Avoid generic names: `den.aspects.config` (too vague)
- Use prefix patterns for related aspects: `den.aspects.editor.vscode`, `den.aspects.editor.helix`

## Related Skills

- **den-entity-manager**: Manage hosts, users, and homes
- **den-policy-writer**: Write policies for entity topology
- **den-quirk-designer**: Design quirks and pipes for cross-cutting concerns
- **den-battery-installer**: Install and configure batteries
- **den-class-creator**: Create custom Nix classes
- **den-settings-manager**: Manage aspect settings

## Resources

- **Documentation**: https://den.denful.dev
- **GitHub**: https://github.com/denful/den
- **Templates**: `nix flake init -t github:denful/den#<template>`
- **Community**: Matrix channel #den-lib:matrix.org
