---
name: den-battery-installer
description: Install and configure Den Framework batteries (reusable aspect providers).
---

# den-battery-installer

**Install and configure Den Framework batteries (reusable aspect providers)**

## Purpose

This skill guides the Pi coding agent in installing, configuring, and composing Den Framework batteries — reusable aspect providers that extend entity behavior without coupling. Batteries are the primary mechanism for adding cross-cutting concerns (user management, hostname setup, package licensing, environment integrations) to Den configurations.

## Use Cases

- Adding OS-level user account management to a NixOS/Darwin configuration
- Setting system hostnames from Den entity data
- Integrating home-manager or alternative home environments
- Enabling WSL support on NixOS
- Allowing unfree or insecure packages selectively
- Forwarding settings between entity classes (user → host, host → user)
- Importing `.nix` files recursively by directory structure
- Sharing `lib`, `inputs`, and `den` to aspect functions and class modules

## Key Den Framework Concepts

### 1. Batteries as Reusable Providers

Batteries live under `den.batteries` (also accessible via `den.provides` and `den._`). They are composable units that can be included in `den.default.includes`, `den.schema.host.includes`, or directly on host/user aspects.

### 2. Opt-in vs Auto-activated Batteries

- **Opt-in batteries** must be explicitly included in `includes` lists
- **Auto-activated batteries** activate automatically when their corresponding class is present (e.g., `nixos`, `user`, `homeManager`)

### 3. Batteries as Functions

Many batteries are factory functions that accept parameters (e.g., shell name, package list, user name) and return a provider module.

### 4. The Forward Battery

The `den.batteries.forward` battery is a generic forwarding primitive that routes content from one class to another. It is the foundation for custom class forwarding.

### 5. Import-tree Battery

`den.batteries.import-tree` recursively imports `.nix` files by directory name, enabling modular configuration organization.

## Battery Reference

### User Management

| Battery | Description | Usage |
|---------|-------------|-------|
| `den.batteries.define-user` | Creates OS-level user accounts with home directory | `den.default.includes = [ den.batteries.define-user ];` |
| `den.batteries.primary-user` | Marks a user as primary (admin-level) user | `den.aspects.alice.includes = [ den.batteries.primary-user ];` |
| `den.batteries.user-shell` | Sets user's login shell at OS and HM levels | `den.batteries.user-shell "fish"` |
| `den.batteries.tty-autologin` | Configures automatic TTY1 login on NixOS | `den.batteries.tty-autologin "alice"` |
| `den.batteries.vm-autologin` | Configures automatic TTY1 login on NixOS VMs | `den.batteries.vm-autologin "alice"` |
| `den.batteries.host-aspects` | Projects user-relevant classes from host's aspect tree onto users | `den.aspects.tux.includes = [ den.batteries.host-aspects ];` |

### System Configuration

| Battery | Description | Usage |
|---------|-------------|-------|
| `den.batteries.hostname` | Sets system hostname from `den.hosts.<name>.hostName` | `den.default.includes = [ den.batteries.hostname ];` |
| `den.batteries.flake-scope` | Exposes `lib`, `inputs`, and `den` to aspect functions | `den.default.includes = [ den.batteries.flake-scope ];` |
| `den.batteries.inputs'` | Provides `inputs'` (flake's inputs with system pre-selected) | `den.default.includes = [ den.batteries.inputs' ];` |
| `den.batteries.self'` | Provides `self'` (flake's self outputs with system pre-selected) | `den.default.includes = [ den.batteries.self' ];` |

### Package Licensing

| Battery | Description | Usage |
|---------|-------------|-------|
| `den.batteries.unfree` | Allows specific unfree packages | `den.batteries.unfree [ "nvidia-x11" "steam" ]` |
| `den.batteries.insecure` | Allows specific insecure packages | `den.batteries.insecure [ "openssl-1.1.1w" ]` |

### Module Organization

| Battery | Description | Usage |
|---------|-------------|-------|
| `den.batteries.forward` | Generic forwarding primitive for custom classes | See forward battery section |
| `den.batteries.import-tree.provides.host` | Recursively imports `.nix` files by directory name | `den.schema.host.includes = [ (den.batteries.import-tree.provides.host ./hosts) ];` |

### Auto-activated Batteries

| Class | Description |
|-------|-------------|
| `os` | Routes `os` class content to host's OS class (`nixos`/`darwin`) |
| `user` | Forwards settings into `users.users.<userName>` at OS level |
| `homeManager` | Integrates home-manager as a user environment class |
| `hjem` | Integrates hjem as an alternative home environment |
| `maid` | Integrates nix-maid as an alternative home environment (NixOS only) |
| `wsl` | Enables WSL support on NixOS when `host.wsl.enable = true` |

## Example Nix Code Snippets

### Example 1: Basic User and Hostname Setup

```nix
{
  den, lib, ...,
}: {
  den.default = {
    nixos.system.stateVersion = "25.11";
    homeManager.home.stateVersion = "25.11";
    includes = [
      den.batteries.define-user
      den.batteries.hostname
      den.batteries.flake-scope
    ];
  };

  den.hosts.x86_64-linux.laptop = {
    hostName = "laptop";
    users.alice = { };
  };

  den.aspects.alice = {
    homeManager = { pkgs, ... }: {
      programs.git.enable = true;
      programs.git.userEmail = "alice@example.com";
    };
  };
}
```

### Example 2: User with Primary Access and Custom Shell

```nix
{
  den, lib, ...,
}:
let
  user = "alice";
in {
  den.default = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
    ];
  };

  den.hosts.x86_64-linux.laptop = {
    users.${user} = {
      classes = [ "homeManager" ];
    };
  };

  den.aspects.${user} = {
    includes = [
      den.batteries.primary-user
      (den.batteries.user-shell "fish")
    ];
    homeManager = { pkgs, ... }: {
      programs.fish.enable = true;
      home.shell = "fish";
    };
  };
}
```

### Example 3: Auto-login Configuration

```nix
{
  den, lib, ...,
}:
let
  user = "alice";
in {
  den.hosts.x86_64-linux.laptop = {
    users.${user} = { };
  };

  den.aspects.laptop = {
    includes = [
      (den.batteries.tty-autologin user)
    ];
  };
}
```

### Example 4: Package Licensing

```nix
{
  den, lib, ...,
}:
{
  den.aspects.laptop = {
    includes = [
      (den.batteries.unfree [
        "nvidia-x11"
        "steam"
        "vscode"
      ])
      (den.batteries.insecure [
        "openssl-1.1.1w"
      ])
    ];
  };
}
```

### Example 5: Forward Battery for Custom Classes

```nix
{
  den, lib, ...,
}:
let
  # Forward user container settings to host nixos class
  containerFwd = { host, user }:
    den.batteries.forward {
      each = lib.singleton user;
      fromClass = _: "container";
      intoClass = _: host.class;
      intoPath = _: [ "virtualisation" "oci-containers" "containers" user.userName ];
      fromAspect = _: user.aspect;
    };
in {
  # Add forward battery to user schema
  den.schema.user.includes = [ containerFwd ];

  den.hosts.x86_64-linux.server = {
    users.deploy = { };
  };

  den.aspects.deploy = {
    container = {
      image = "myapp:latest";
      ports = [ "8080:80" ];
    };
  };
}
```

### Example 6: Import-tree for Modular Host Configuration

```nix
{
  den, lib, ...,
}:
{
  den.schema.host.includes = [
    (den.batteries.import-tree.provides.host ./hosts)
  ];
}
```

Directory structure:
```
hosts/
├── laptop.nix    → imported as den.hosts.x86_64-linux.laptop
├── desktop.nix   → imported as den.hosts.x86_64-linux.desktop
└── server.nix    → imported as den.hosts.x86_64-linux.server
```

### Example 7: Complete Practical Setup

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    den.url = "github:denful/den";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { den, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        laptop = den.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            den.flakeModules.default
            ({ den, ... }:
            let
              user = "alice";
            in {
              den.hosts.x86_64-linux.laptop = {
                hostName = "laptop";
                users.${user} = {
                  classes = [ "homeManager" ];
                };
              };

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

              den.aspects.${user} = {
                homeManager = { pkgs, ... }: {
                  programs.git.enable = true;
                  programs.vscode.enable = true;
                  programs.fish.enable = true;
                };
              };

              den.aspects.laptop = {
                includes = [
                  (den.batteries.unfree [ "steam" ])
                ];
                nixos = { pkgs, ... }: {
                  hardware.bluetooth.enable = true;
                };
                homeManager = { pkgs, ... }: {
                  services.blueman-applet.enable = true;
                };
              };
            })
          ];
        };
      };
    };
  };
}
```

## Best Practices

### 1. Always Include Required Batteries

Missing batteries cause silent failures. Always include batteries that your configuration depends on:

```nix
# WRONG - users won't be created
den.hosts.x86_64-linux.laptop.users.alice = { };

# RIGHT - include define-user battery
den.default.includes = [ den.batteries.define-user ];
den.hosts.x86_64-linux.laptop.users.alice = { };
```

### 2. Use `den.default` for Shared Configuration

Put batteries and shared settings in `den.default` so they apply to all entities:

```nix
den.default = {
  includes = [
    den.batteries.define-user
    den.batteries.hostname
    den.batteries.flake-scope
  ];
};
```

### 3. Add Classes Explicitly

Home Manager and other auto-activated batteries require the class to be present:

```nix
# WRONG - homeManager won't activate
den.hosts.x86_64-linux.laptop.users.alice = { };

# RIGHT - add homeManager class
den.hosts.x86_64-linux.laptop.users.alice.classes = [ "homeManager" ];
```

### 4. Use Parameterized Batteries Correctly

Many batteries are functions. Call them with the right arguments:

```nix
# WRONG - battery not invoked
den.aspects.alice.includes = [ den.batteries.user-shell ];

# RIGHT - call the function with the shell name
den.aspects.alice.includes = [ (den.batteries.user-shell "fish") ];
```

### 5. Leverage Forward Battery for Custom Classes

Use `den.batteries.forward` to create custom class forwarding patterns:

```nix
den.schema.user.includes = [
  ({ host, user }:
    den.batteries.forward {
      each = lib.singleton user;
      fromClass = _: "my-custom-class";
      intoClass = _: host.class;
      intoPath = _: [ "my" "custom" "path" ];
      fromAspect = _: user.aspect;
    })
];
```

### 6. Use `den.batteries.host-aspects` for Host-to-User Projection

When you want host-level aspects to flow down to users:

```nix
den.aspects.tux.includes = [ den.batteries.host-aspects ];
```

### 7. Combine Batteries with Aspects

Batteries can be included in aspect `includes` lists alongside other aspects:

```nix
den.aspects.workstation = {
  includes = [
    den.batteries.primary-user
    den.aspects.dev-tools
    den.aspects.gaming
  ];
  nixos.services.xserver.enable = true;
};
```

## Common Patterns

### Pattern 1: Multi-User Setup

```nix
{
  den, lib, ...,
}:
let
  users = [ "alice" "bob" ];
in {
  den.default = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
    ];
  };

  den.hosts.x86_64-linux.server = {
    users = lib.genAttrs users (_: { classes = [ "homeManager" ]; });
  };

  # Per-user aspects
  den.aspects.alice = {
    homeManager = { pkgs, ... }: {
      programs.git.enable = true;
    };
  };
  den.aspects.bob = {
    homeManager = { pkgs, ... }: {
      programs.vim.enable = true;
    };
  };
}
```

### Pattern 2: Conditional Package Licensing

```nix
{
  den, lib, host, ...,
}:
{
  den.aspects.${host.aspect} = {
    includes = lib.optionals (host ? gpu && host.gpu == "nvidia") [
      (den.batteries.unfree [ "nvidia-x11" ])
    ];
  };
}
```

### Pattern 3: Environment-Specific Batteries

```nix
{
  den, lib, host, ...,
}:
{
  den.default = {
    includes = [
      den.batteries.define-user
      den.batteries.hostname
    ] ++ lib.optionals host.wsl.enable [
      den.batteries.wsl
    ];
  };
}
```

## Integration Instructions for Pi Coding Agent

### When to Use This Skill

Use this skill when:
1. Adding user account management to a Den configuration
2. Setting up hostname configuration from Den entity data
3. Integrating home-manager or alternative home environments
4. Configuring WSL support on NixOS
5. Allowing unfree or insecure packages
6. Creating custom class forwarding patterns
7. Organizing configuration with import-tree
8. Sharing `lib`, `inputs`, or `den` to aspect functions

### Quick Checklist

- [ ] Determine which batteries are needed for the configuration
- [ ] Add batteries to `den.default.includes` or entity-specific `includes`
- [ ] For parameterized batteries, call the function with correct arguments
- [ ] Ensure required classes are declared on users/hosts
- [ ] Verify battery activation order (use `den.default` for shared batteries)
- [ ] Test with `nix flake check`

### Common Pitfalls

1. **Forgetting to include `define-user`**: Users won't be created without this battery
2. **Missing `homeManager` class**: Home Manager won't activate without the class
3. **Not invoking parameterized batteries**: Batteries like `user-shell` are functions — call them
4. **Wrong scope for batteries**: Some batteries must be in `den.default`, not on individual aspects
5. **Missing `flake-scope`**: Aspect functions can't access `lib` or `inputs` without this battery

## Related Skills

- **den-aspect-creator**: Use together when creating aspects that consume battery-provided classes
- **den-entity-manager**: Use together when defining hosts and users that batteries act upon
- **den-policy-writer**: Use together when policies need battery-provided data
- **den-quirk-designer**: Use together when quirks interact with battery-provided classes
- **den-class-creator**: Use together when creating custom classes that use the forward battery
- **den-settings-manager**: Use together when settings interact with battery-provided classes

## References

- Den Framework Batteries Documentation: `docs/den/07-batteries.md`
- Den Framework Practical Guide: `docs/den/16-practical-guide.md`
- Den Framework Custom Classes: `docs/den/08-custom-classes.md`
- Den Framework Quirks & Pipes: `docs/den/06-quirks-pipes.md`
- Den Framework Core Principles: `docs/den/01-core-principles.md`
- Den Framework Entities & Schema: `docs/den/02-entities-schema.md`
- Den Framework Aspects: `docs/den/03-aspects.md`
