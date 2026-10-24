---
name: den-entity-manager
description: Manage Den entities (hosts, users, homes) and schema definitions for NixOS, nix-Darwin, and home-manager configurations.
---

# Den Entity Manager

Manage Den entities (hosts, users, homes) and schema definitions for NixOS, nix-Darwin, and home-manager configurations.

## Purpose

This skill guides the Pi coding agent in creating, configuring, and managing **Den entities** — the foundational data structures that define what exists in your infrastructure. Entities are the "what" layer of Den, sitting beneath aspects (the "what it does" layer).

## Use Cases

- Creating and configuring NixOS hosts and nix-Darwin machines
- Defining system users with their classes and attributes
- Setting up standalone home-manager configurations
- Extending entity schemas with custom options
- Managing entity topology through policies
- Cross-entity configuration via `provides`

---

## Core Concepts

### Entity Kinds

| Kind | Declared In | Produces | Key Format |
|------|-------------|----------|------------|
| **Host** | `den.hosts` | `nixosConfigurations` / `darwinConfigurations` | `<system>.<name>` |
| **User** | `den.hosts.<sys>.<host>.users` | `users.users.<name>` NixOS entries | `<name>` (inline) |
| **Home** | `den.homes` | `homeConfigurations` | `<system>.<name>` or `user@host` |

### Entity Resolution Pipeline

```
den.hosts.x86_64-linux.laptop
  ↓
host stage {host}
  ↓
user stage {host, user} (for each user)
  ↓
HM → homeManager class
OS → nixos/darwin class
```

---

## Host Entities

### Basic Host Declaration

```nix
# modules/hosts/laptop.nix
{ den, ... }: {
  den.hosts.x86_64-linux.laptop = {
    # hostName defaults to the attr name ("laptop")
    # class auto-detected as "nixos" from x86_64-linux
    users.alice = { };
    users.bob = {
      classes = [ "homeManager" ];
    };
  };
};
```

### Host Options Reference

| Option | Default | Description |
|--------|---------|-------------|
| `name` | attrset key | Configuration name |
| `hostName` | `name` | Network hostname |
| `system` | parent key | `x86_64-linux`, `aarch64-darwin`, etc. |
| `class` | auto-detected | `"nixos"` or `"darwin"` from system |
| `aspect` | `name` | Primary aspect name |
| `instantiate` | class-dependent | `lib.nixosSystem`, `darwinSystem`, etc. |
| `intoAttr` | class-dependent | Flake output path |
| `users` | `{}` | User account definitions |
| `*` | freeform | Any additional attribute |

### Host with Custom Options

```nix
{ den, lib, ... }: {
  den.hosts.x86_64-linux.server = {
    # Freeform attributes — accessible in aspects
    datacenter = "eu-west-1";
    role = "web";
    
    users.webmaster = {
      classes = [ "homeManager" ];
    };
  };
  
  # Access freeform in aspects
  den.aspects.datacenter-config = {
    nixos = { host, ... }: lib.optionalAttrs
      (host ? datacenter && host.datacenter == "eu-west-1") {
      # Only applies when datacenter matches
      networking.nameservers = [ "10.0.0.53" ];
    };
  };
  
  den.aspects.server.includes = [ den.aspects.datacenter-config ];
};
```

---

## User Entities

### Basic User Declaration

```nix
{ den, ... }: {
  den.hosts.x86_64-linux.laptop.users.alice = {
    # Default: classes = [ "user" ]
    # Add homeManager class for home-manager integration
  };
  
  den.hosts.x86_64-linux.laptop.users.bob = {
    classes = [ "homeManager" "hjem" ];
  };
};
```

### User Options Reference

| Option | Default | Description |
|--------|---------|-------------|
| `name` | attrset key | User configuration name |
| `userName` | `name` | System account name |
| `aspect` | `name` | Primary aspect name |
| `classes` | `[ "user" ]` | Nix classes this user participates in |
| `*` | freeform | Any additional attribute |

### User with Custom Attributes

```nix
{ den, ... }: {
  den.hosts.x86_64-linux.laptop.users.alice = {
    userName = "alice-admin";
    classes = [ "homeManager" ];
    isAdmin = true;
    preferredEditor = "helix";
  };
};
```

### Critical: Home Manager Class

```nix
# WRONG — user won't get home-manager config
# (missing homeManager class)
den.hosts.x86_64-linux.laptop.users.alice = { };

# RIGHT — add homeManager class
den.hosts.x86_64-linux.laptop.users.alice.classes = [ "homeManager" ];
```

### Critical: Define-User Battery

```nix
# WRONG — users won't be created at OS level
# (missing battery)
den.hosts.x86_64-linux.laptop.users.alice = { };

# RIGHT — include define-user battery
den.default.includes = [ den.batteries.define-user ];
```

---

## Home Entities

### Basic Home Declaration

```nix
{ den, ... }: {
  den.homes.x86_64-linux.alice = {
    # Standalone home-manager configuration
    # Keyed by system.name or user@host
  };
  
  den.homes.aarch64-darwin.alice = {
    # Same user, different system
  };
};
```

### Home Options Reference

| Option | Default | Description |
|--------|---------|-------------|
| `name` | attrset key | Configuration name |
| `userName` | `name` | User account name |
| `system` | parent key | Platform system |
| `class` | `"homeManager"` | Home class |
| `pkgs` | nixpkgs legacy | nixpkgs instance |
| `instantiate` | homeManagerConfiguration | Builder function |

### Home Bound to Host User

```nix
{ den, ... }: {
  den.hosts.x86_64-linux.laptop.users.alice.classes = [ "homeManager" ];
  
  den.homes.x86_64-linux.alice = {
    # This home is automatically bound to alice on laptop
    # because alice has the homeManager class
  };
};
```

---

## Schema Definitions

### Schema for Entity Kinds

`den.schema` lets you define options that apply to **every** entity of a given kind:

```nix
{ den, lib, ... }: {
  # Enable home-manager for all hosts
  den.schema.host.home-manager.enable = true;
  
  # Add custom option to every user
  den.schema.user = { user, lib, ... }: {
    options.groupName = lib.mkOption {
      default = user.userName;
      description = "Group name for this user";
    };
  };
  
  # Shared across all entity kinds
  den.schema.conf = {
    options.copyright = lib.mkOption {
      default = "Copy-Left";
      description = "Copyright notice";
    };
  };
};
```

### Strict Mode

Enable strict typing to catch unknown attributes:

```nix
# Enable strict mode for all hosts
inputs.den.flakeModules.strict;

# Or per-kind
{ den, ... }: {
  den.schema.host = den.lib.strict;
  
  # Or
  den.schema.host.isStrict = true;
};
```

### Custom Entity Types

```nix
{ den, lib, ... }: {
  # Define a custom entity kind
  den.schema.environment.isEntity = true;
  
  # Declare it in den.environments
  den.environments.production = {
    name = "production";
  };
};
```

---

## Cross-Entity Configuration

### Provides to Users

```nix
{ den, ... }: {
  # Host provides to ALL users on this host
  den.aspects.laptop.provides.to-users = { user, ... }: {
    homeManager.programs.helix.enable = user.name == "alice";
  };
  
  # Host provides to a specific user by name
  den.aspects.laptop.provides.alice.homeManager.programs.vim.enable = true;
};
```

### Provides to Hosts

```nix
{ den, ... }: {
  # User provides to ALL hosts this user lives on
  den.aspects.alice.provides.to-hosts = { host, ... }: {
    nixos.programs.nh.enable = host.name == "igloo";
  };
  
  # User provides to a specific host by name
  den.aspects.alice.provides.igloo.nixos.programs.emacs.enable = true;
};
```

### Host-Qualified Aspects

User-scoped entities look for both a host-qualified aspect and a bare one:

```
Entity          → Aspects applied
user `tux` on `igloo` → `den.aspects."tux@igloo"` and `den.aspects.tux`
home `tux@igloo` → `den.aspects."tux@igloo"` and `den.aspects.tux`
home `tux` → `den.aspects.tux`
```

---

## den.default — Shared Configuration

A special aspect applied to every host, user, and home:

```nix
{ den, ... }: {
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
};
```

---

## Practical Examples

### Example 1: Complete Host with Users

```nix
{ den, lib, pkgs, ... }: {
  den.hosts.x86_64-linux.workstation = {
    hostName = "workstation";
    
    users.alice = {
      userName = "alice";
      classes = [ "homeManager" ];
      isAdmin = true;
    };
    
    users.bob = {
      classes = [ "homeManager" ];
    };
  };
  
  den.default = {
    nixos.system.stateVersion = "25.11";
    includes = [ den.batteries.define-user ];
  };
  
  den.aspects.workstation = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [ git vim neovim ];
    };
    homeManager = { pkgs, ... }: {
      programs.git.enable = true;
      programs.neovim.enable = true;
    };
  };
  
  den.aspects.workstation.includes = [ den.aspects.workstation ];
};
```

### Example 2: Multi-System User (Linux + Darwin)

```nix
{ den, ... }: {
  # Linux host
  den.hosts.x86_64-linux.server = {
    users.deploy = { classes = [ "homeManager" ]; };
  };
  
  # Darwin host
  den.hosts.aarch64-darwin.macbook = {
    users.alice = { classes = [ "homeManager" ]; };
  };
  
  # Shared home for alice across systems
  den.homes.x86_64-linux.alice = { };
  den.homes.aarch64-darwin.alice = { };
};
```

### Example 3: Conditional User Setup

```nix
{ den, lib, ... }: {
  den.hosts.x86_64-linux.laptop.users.alice = {
    classes = [ "homeManager" ];
    isPrimary = true;
  };
  
  den.aspects.primary-user-setup = {
    nixos = { host, lib, ... }: lib.mkIf
      (host.users ? alice && host.users.alice.isPrimary) {
      users.users.alice.extraGroups = [ "wheel" "docker" ];
    };
  };
  
  den.aspects.laptop.includes = [ den.aspects.primary-user-setup ];
};
```

### Example 4: Schema with Custom Options

```nix
{ den, lib, ... }: {
  den.schema.user = { user, lib, ... }: {
    options.groupName = lib.mkOption {
      type = lib.types.str;
      default = user.userName;
      description = "Group name for this user";
    };
    options.isDeveloper = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether this user is a developer";
    };
  };
  
  den.hosts.x86_64-linux.laptop.users.alice = {
    classes = [ "homeManager" ];
    groupName = "developers";
    isDeveloper = true;
  };
};
```

---

## Best Practices

### 1. Always Include Required Batteries

```nix
# Required for users to be created at OS level
den.default.includes = [ den.batteries.define-user ];

# Required for hostname to be set
den.default.includes = [ den.batteries.hostname ];

# Required for lib/inputs/den access in aspects
den.default.includes = [ den.batteries.flake-scope ];
```

### 2. Always Set homeManager Class

```nix
# WRONG — user won't get home-manager config
den.hosts.x86_64-linux.laptop.users.alice = { };

# RIGHT — add homeManager class
den.hosts.x86_64-linux.laptop.users.alice.classes = [ "homeManager" ];
```

### 3. Use Parametric Aspects for Context-Dependent Config

```nix
# Good — activates only in {host} context
den.aspects.networking = { host, ... }: {
  nixos.networking.hostName = host.name;
};

# Bad — static, won't adapt to context
den.aspects.networking.nixos.networking.hostName = "laptop";
```

### 4. Keep Entities Minimal, Aspects Rich

```nix
# Good — entity is just data
den.hosts.x86_64-linux.laptop = {
  gpu = "nvidia";
  users.alice = { classes = [ "homeManager" ]; };
};

# Good — aspects contain the logic
den.aspects.gpu-config = { host, lib, ... }: {
  nixos = lib.optionalAttrs (host ? gpu) {
    hardware.nvidia.enable = true;
  };
};
```

### 5. Use den.default for Shared Configuration

```nix
den.default = {
  nixos.system.stateVersion = "25.11";
  homeManager.home.stateVersion = "25.11";
  includes = [ den.batteries.define-user ];
};
```

### 6. Use Freeform Attributes for Host-Specific Data

```nix
# Declare data on entity
den.hosts.x86_64-linux.laptop.gpu = "nvidia";

# Access in parametric aspect
den.aspects.gpu = { host, lib, ... }: {
  nixos = lib.optionalAttrs (host ? gpu) {
    hardware.nvidia.enable = true;
  };
};
```

---

## Common Mistakes

### Mistake 1: Home Manager on Host Aspect

```nix
# WRONG — host scope homeManager has nowhere to go
den.aspects.laptop.homeManager.programs.vim.enable = true;

# RIGHT — use provides.to-users
den.aspects.laptop.provides.to-users.homeManager.programs.vim.enable = true;
```

### Mistake 2: Missing Classes for Home Manager

```nix
# WRONG — user doesn't have homeManager class
den.hosts.x86_64-linux.laptop.users.alice = { };

# RIGHT — add homeManager class
den.hosts.x86_64-linux.laptop.users.alice.classes = [ "homeManager" ];
```

### Mistake 3: Forgetting to Include Batteries

```nix
# WRONG — users won't be created
den.hosts.x86_64-linux.laptop.users.alice = { };

# RIGHT — include define-user battery
den.default.includes = [ den.batteries.define-user ];
```

### Mistake 4: Hardcoding Host Names

```nix
# WRONG — won't adapt to different hosts
den.aspects.networking.nixos.networking.hostName = "laptop";

# GOOD — uses context
den.aspects.networking = { host, ... }: {
  nixos.networking.hostName = host.name;
};
```

---

## Integration Instructions for Pi Coding Agent

### When to Use This Skill

Use this skill when:
- Creating or modifying NixOS hosts (`den.hosts`)
- Defining system users (`den.hosts.<sys>.<host>.users`)
- Setting up home-manager configurations (`den.homes`)
- Extending entity schemas (`den.schema`)
- Configuring cross-entity configuration (`provides`)
- Setting up `den.default` shared configuration

### Quick Checklist

1. **Entity declaration**: `den.hosts.<system>.<name>` or `den.homes.<system>.<name>`
2. **User class**: Always include `"homeManager"` if using home-manager
3. **Batteries**: Always include `den.batteries.define-user` for users
4. **Parametric aspects**: Use `{ host, ... }:` for host-dependent config
5. **Freeform attributes**: Use entity attrs for host-specific data
6. **Schema**: Use `den.schema` for cross-entity options
7. **Strict mode**: Enable for catching unknown attributes

### File Structure Convention

```
flake.nix
modules/
  hosts/
    laptop.nix      # den.hosts.x86_64-linux.laptop
    server.nix      # den.hosts.x86_64-linux.server
  users/
    alice.nix       # den.hosts.<sys>.<host>.users.alice
  homes/
    alice.nix       # den.homes.x86_64-linux.alice
  schema/
    users.nix       # den.schema.user
  default.nix       # den.default
```

### Testing Entity Configurations

```nix
# Use den.lib.aspects.resolve to test entity resolution
let
  resolved = den.lib.aspects.resolve "nixos" (den.lib.resolveEntity "host" {
    host = den.hosts.x86_64-linux.laptop;
  });
in { nixosConfigurations.laptop = resolved; }
```

---

## API Quick Reference

### Entity Declaration

```nix
den.hosts.<system>.<name> = { ... };
den.homes.<system>.<name> = { ... };
den.hosts.<sys>.<host>.users.<name> = { ... };
den.schema.<kind> = { ... };
den.default = { ... };
```

### Entity Options

```nix
# Host
host.name          # Configuration name
host.hostName      # Network hostname
host.system        # Platform system
host.class         # OS class (nixos/darwin)
host.users         # User definitions
host.*             # Freeform attributes

# User
user.name          # User configuration name
user.userName      # System account name
user.classes       # Nix classes
user.*             # Freeform attributes

# Home
home.name          # Home configuration name
home.userName      # User account name
home.system        # Platform system
home.class         # Always "homeManager"
```

### Cross-Entity Provides

```nix
# Host → all users
den.aspects.<host>.provides.to-users = { user, ... }: { ... };

# Host → specific user
den.aspects.<host>.provides.<user>.<class>.<path> = ...;

# User → all hosts
den.aspects.<user>.provides.to-hosts = { host, ... }: { ... };

# User → specific host
den.aspects.<user>.provides.<host>.<class>.<path> = ...;
```

---

## Related Skills

- **den-aspect-creator** — Create and manage Den aspects for configuration
- **den-policy-writer** — Write policies for entity topology and data routing
- **den-battery-installer** — Install and configure Den batteries
- **den-class-creator** — Create custom Nix classes
- **den-quirk-designer** — Design quirks and pipes for cross-cutting concerns
- **den-core-concepts** — Overview of Den Framework architecture

---

## Further Reading

- [Den Documentation](https://den.denful.dev)
- [GitHub](https://github.com/denful/den)
- [Templates](https://github.com/denful/den#templates)
- [Community](https://matrix.to/#/#den-lib:matrix.org)

---

## Key Takeaways

1. **Entities are data** — hosts, users, homes are typed records
2. **Users are inline** — declared on hosts, not top-level entities
3. **Schema extends** — `den.schema` adds options to all entities of a kind
4. **Classes matter** — always include `"homeManager"` for home-manager users
5. **Batteries are required** — `define-user` creates OS accounts
6. **Freeform attributes** — use entity attrs for host-specific data
7. **Cross-entity routing** — `provides.to-users` and `provides.to-hosts`
8. **den.default applies** to every entity — use for shared config
9. **Strict mode catches** — enable to catch unknown attributes
10. **Parametric dispatch** — use function args for conditional config
