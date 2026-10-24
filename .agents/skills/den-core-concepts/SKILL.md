# Den Core Concepts

Aspect-oriented Nix configuration framework that inverts traditional host-first patterns by making **aspects (features)** the primary organizational unit.

## Overview

Den separates configuration into **four orthogonal concerns**:

| Concern | Declares | Example |
|---------|----------|---------|
| **Entity** | What exists | `den.hosts.x86_64-linux.laptop` |
| **Aspect** | What it does | `den.aspects.bluetooth` |
| **Policy** | How entities relate | `den.policies.host-to-users` |
| **Quirk** | Structured data flow | `den.quirks.firewall` |

**Key principle**: Feature-first, not host-first. Aspects are primary, hosts just select them.

---

## 1. Entity — What Exists

Entities are **typed data records** — hosts, users, or homes. They declare what exists in your infrastructure.

### Host Entities

```nix
den.hosts.x86_64-linux.laptop.users.alice = {};
den.hosts.x86_64-linux.laptop.users.bob.classes = [ "homeManager" ];
```

Each host produces a `nixosConfigurations` or `darwinConfigurations` flake output depending on its `class` (auto-detected from platform).

**Host options**:
- `name` — Configuration name (attrset key)
- `hostName` — Network hostname (defaults to name)
- `system` — Platform (e.g., `x86_64-linux`)
- `class` — OS class (auto-detected: `nixos` or `darwin`)
- `aspect` — Primary aspect name (defaults to name)
- `users` — User account definitions
- `*` — Any freeform attribute

### User Entities

Users are declared inline on a host:

```nix
den.hosts.x86_64-linux.laptop.users.alice = {
  classes = [ "homeManager" "hjem" ];
  groupName = "developers";  # freeform attribute
};
```

**User options**:
- `name` — User configuration name
- `userName` — System account name (defaults to name)
- `aspect` — Primary aspect name
- `classes` — Nix classes this user participates in (default: `[ "user" ]`)
- `*` — Any freeform attribute

### Home Entities

Standalone home-manager configurations:

```nix
den.homes.x86_64-linux.alice = {};
den.homes.aarch64-darwin.alice = {};
```

**Home options**:
- `name` — Home configuration name
- `userName` — User account name
- `system` — Platform system
- `class` — Always `"homeManager"`
- `pkgs` — nixpkgs instance
- `instantiate` — Builder function (default: `homeManagerConfiguration`)

### Freeform Attributes

All entity types use `freeformType`:

```nix
den.hosts.x86_64-linux.laptop = {
  gpu = "nvidia";
  datacenter = "eu-west";
};
```

Access in aspects via entity context:

```nix
den.aspects.laptop.includes = [
  ({ host, ... }:
    lib.optionalAttrs (host ? gpu) {
      nixos.hardware.nvidia.enable = true;
    })
];
```

### Schema Definitions

`den.schema` lets you define options that apply to **every** entity of a given kind:

```nix
{ # Enable home-manager for all hosts
  den.schema.host.home-manager.enable = true;
  
  # Add custom option to every user
  den.schema.user = { user, lib, ... }: {
    options.groupName = lib.mkOption {
      default = user.userName;
    };
  };
  
  # Shared across all entity kinds
  den.schema.conf = {
    options.copyright = lib.mkOption { default = "Copy-Left"; };
  };
}
```

### Strict Mode

Enable strict typing for a kind:

```nix
den.schema.host = den.lib.strict;
# or
den.schema.host.isStrict = true;
```

**Anti-pattern**: Don't mix legacy and Den options in the same module. Use Den's aspect system exclusively.

---

## 2. Aspect — What It Does

An aspect is a **composable unit of configuration** that bundles modules for one or more Nix classes.

### Aspect Structure

```nix
den.aspects.gaming = { host, user }: {
  nixos = { pkgs, ... }: { programs.steam.enable = true; };
  homeManager = { pkgs, ... }: { programs.mangohud.enable = true; };
  includes = [ den.aspects.performance ];
};
```

Three kinds of attributes:
1. **Owned Configurations** — Direct settings per Nix class (`nixos`, `darwin`, `homeManager`)
2. **Includes** — List forming a dependency graph (DAG)
3. **Nested Aspects** — Any key that is not a class or structural key

### Parametric Aspects

Aspects can be functions that receive context:

```nix
# Only activates in {host} contexts
den.aspects.networking = { host, ... }: {
  nixos.networking.hostName = host.name;
};

# Only when both {host, user} are present
den.aspects.user-groups = { host, user, ... }: {
  nixos.users.users.${user.userName}.extraGroups = [ "wheel" ];
};
```

**Dispatch rules** when an aspect destructures an entity-kind arg:
1. **In-context** → bind once at current scope
2. **Schema-DAG descendant** → fan out once per descendant, emit at current scope
3. **Neither** → inert, silently contributes nothing

### Static Aspects

Plain attrsets are always included:

```nix
den.aspects.firewall = {
  nixos.networking.firewall.enable = true;
};
```

### Includes (DAG)

Aspects form a DAG through `includes`:

```nix
den.aspects.workstation = {
  includes = [
    den.aspects.dev-tools
    den.aspects.gaming.emulation
    den.batteries.primary-user
  ];
  nixos.services.xserver.enable = true;
};
```

Three kinds of include values:
1. **Static (plain attrset)**: `{ nixos.foo = ...; }`
2. **Static (aspect leaf)**: `{ class, aspect-chain }: { ${class}.foo = ...; }`
3. **Parametric (function)**: `{ host, user }: { ${host.class}.foo = ...; }`

### Nested Aspects

Any key that is not a class or structural key is a nested aspect:

```nix
den.aspects.tools.editors = {
  homeManager.programs.helix.enable = true;
  homeManager.programs.vim.enable = true;
};

# Used elsewhere:
den.aspects.alice.includes = [ den.aspects.tools.editors ];
```

### Cross-Entity Provides

Special `provides` keys route configuration across entity boundaries:

```nix
den.aspects.igloo = {
  # Deliver to ALL users on this host
  provides.to-users = { user, ... }: {
    homeManager.programs.helix.enable = user.name == "alice";
  };
  # Deliver to a specific user by name
  provides.alice.homeManager.programs.vim.enable = true;
};

den.aspects.tux = {
  # Deliver to ALL hosts this user lives on
  provides.to-hosts = { host, ... }: {
    nixos.programs.nh.enable = host.name == "igloo";
  };
  # Deliver to a specific host by name
  provides.igloo.nixos.programs.emacs.enable = true;
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

### Meta

Aspects have a `meta` submodule for metadata:

```nix
den.aspects.igloo.meta.foo = "bar";
```

Default meta attributes:
- `aspect.name` — Aspect name (e.g., "igloo")
- `aspect.meta.loc` — Location path from which name is derived
- `aspect.meta.name` — Full name (e.g., "den.aspects.igloo")
- `aspect.meta.file` — Last file where this aspect was defined
- `aspect.meta.self` — Reference to the aspect module

---

## 3. Policy — How Entities Relate

A policy is a **function from context to a list of effects**.

### Policy Structure

```nix
let inherit (den.lib) policy;
den.policies.host-to-users = { host, ... }:
  map (user: policy.resolve.to "user" { inherit host user; })
    (lib.attrValues host.users);
```

Policies are **first-class values** — they live in `den.policies` as a registry and are **activated** by including them in `includes` lists.

### Effect Families

- `resolve` — Enrich current scope or fan out a child entity
- `include` — Inject an aspect to walk through the tree
- `route` — Move class content between scopes
- `provide` — Deliver a module straight to a class
- `exclude` — Prevent a policy from firing
- `instantiate` — Create a new entity
- `spawn` — Create a sibling scope
- `pipe` — Route, filter, transform, or aggregate quirk data

### Enrichment vs Entity Resolution

```nix
# Enrichment — adds myFlag to current context, no new scope
policy.resolve { myFlag = true; }

# Entity resolution — creates a child "user" scope
policy.resolve.to "user" { inherit host user; }
```

### Activation

Declaring a policy only **registers** it. Activation happens via `includes`:

```nix
# Register
den.policies.my-enrichment = { host, ... }: [ /* effects */ ];
# Activate for all hosts
den.schema.host.includes = [ den.policies.my-enrichment ];
```

### Conditional Policies

```nix
# Fire only when a specific entity is in context
den.lib.policy.for den.hosts.x86_64-linux.igloo den.policies.my-policy

# Fire only when a predicate is true
den.lib.policy.when ({ host, ... }: host.wsl.enable) den.policies.wsl-support
```

---

## 4. Quirk — Structured Data Flow

A **quirk** is structured data emitted by an aspect on a named key registered in `den.quirks`.

### Declaring a Quirk

```nix
den.quirks.firewall = {
  description = "Firewall port declarations";
};
```

### Emitting Quirks

```nix
den.aspects.nginx = {
  nixos.services.nginx.enable = true;
  firewall = { ports = [ 80 443 ]; };
};

den.aspects.postgres = {
  nixos.services.postgresql.enable = true;
  firewall = { ports = [ 5432 ]; };
};
```

### Consuming Quirks

```nix
den.aspects.networking = {
  nixos = { firewall, lib, ... }: {
    networking.firewall.allowedTCPPorts =
      lib.concatMap (f: f.ports or []) firewall;
  };
};
```

### Pipes

Route quirks across scopes:

```nix
den.policies.filter-tcp = { host, ... }:
  let inherit (den.lib.policy) pipe;
  in [ (pipe.from "firewall" [
    (pipe.filter (e: e.proto == "tcp"))
  ]) ];
```

Pipe stages:
- `pipe.from` — Start collecting from a quirk
- `pipe.filter` — Filter collected values
- `pipe.transform` — Transform collected values
- `pipe.as` — Rename to a derived quirk
- `pipe.expose` — Flow child-scope data upward
- `pipe.collect` — Harvest data from sibling scopes
- `pipe.broadcast` — Broadcast to all sibling scopes

---

## The Resolution Pipeline

1. **Host resolution** — For each `den.hosts.<system>.<name>`, creates a `host` scope
2. **Core policy fans out** — `host-to-users` policy creates user scopes
3. **Battery policies forward** — Home environment batteries forward user configs
4. **Deduplication** — Tracks seen aspects per scope
5. **Home configurations** — Standalone homes resolved separately
6. **Output** — Flake policies assemble final configurations

```
start → host → host-to-users → user → host-to-hm-users → home-manager
```

### Policy Activation Fixed-Point

When pipeline reaches an entity scope:

1. **Collect** — Gather all active policies from include chain
2. **Check satisfaction** — Introspect function args, fire only when all required args present
3. **Fire** — Call satisfied policies, collect effects
4. **Enrich** — If effects add new context keys, merge and drain deferred includes
5. **Iterate** — If enrichment introduced new keys, repeat from step 2
6. **Converge** — When no new keys added, emit collected effects

**Capped at 10 iterations** — throws `den: enrichment cycle` if still growing.

---

## Key Principles

### Feature-First, Not Host-First

Traditional setups start from hosts and push modules down. Den inverts this: aspects (features) are primary, hosts just select them.

### Context-Driven Dispatch

Den uses **function parametric dispatch**: aspect functions declare which context parameters they need via their argument pattern. No `mkIf`, no `enable` — the context shape **is** the condition.

### Composition via Includes

Aspects form a DAG through `includes` and a tree through nesting.

### Separation of Concerns

| Layer | Purpose | Example |
|-------|---------|---------|
| Schema | Declare entities | `den.hosts.x86_64-linux.laptop.users.alice = {}` |
| Aspects | Configure behavior | `den.aspects.laptop.nixos.networking.hostName = "laptop"` |
| Policies | Entity topology and routing | `den.policies.host-to-users` |
| Quirks | Structured data flow | `den.quirks.firewall` + `pipe.collect` |
| Batteries | Reusable patterns | `den.batteries.primary-user` |

---

## Common Patterns

### Pattern 1: Feature-First Organization

```nix
# modules/aspects/dev-tools.nix
{ pkgs, ... }: {
  nixos = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ git vim ];
  };
  homeManager = { pkgs, ... }: {
    programs.git.enable = true;
    programs.vim.enable = true;
  };
};

# modules/hosts/laptop.nix
{ den, ... }: {
  den.aspects.laptop.includes = [ den.aspects.dev-tools ];
};
```

### Pattern 2: Parametric Configuration

```nix
# modules/aspects/gpu.nix
{ host, lib, ... }: {
  nixos = lib.optionalAttrs (host ? gpu && host.gpu != null) {
    hardware.nvidia.enable = true;
  };
};

# modules/hosts/laptop.nix
{ den, ... }: {
  den.hosts.x86_64-linux.laptop.gpu = "nvidia";
  den.aspects.laptop.includes = [ den.aspects.gpu ];
};
```

### Pattern 3: Cross-Entity Configuration

```nix
# User provides to host
den.aspects.alice.provides.to-hosts.nixos = { pkgs, ... }: {
  nixos.programs.nh.enable = true;
};

# Host provides to users
den.aspects.laptop.provides.to-users.homeManager = { pkgs, ... }: {
  home.packages = [ pkgs.vim ];
};
```

### Pattern 4: Quirk-Based Data Aggregation

```nix
# Declare quirk
den.quirks.ports = { description = "Network port declarations"; };

# Emit from multiple aspects
den.aspects.nginx.ports = { tcp = [ 80 443 ]; };
den.aspects.postgres.ports = { tcp = [ 5432 ]; };

# Consume in single aspect
den.aspects.networking.nixos = { ports, lib, ... }: {
  networking.firewall.allowedTCPPorts =
    lib.concatMap (p: p.tcp or []) ports;
};
```

---

## Anti-Patterns to Avoid

### 1. Don't Use mkIf for Context

```nix
# Bad
den.aspects.networking.nixos = {
  networking.hostName = mkIf (host.name == "laptop") "laptop";
};

# Good
den.aspects.networking = { host, ... }: {
  nixos.networking.hostName = host.name;
};
```

### 2. Don't Use Strings for Aspect References

```nix
# Bad
modules = [ "dev-tools" "gaming" ];

# Good
includes = [ den.aspects.dev-tools den.aspects.gaming ];
```

### 3. Don't Hardcode Host Names

```nix
# Bad
nixos.networking.hostName = "laptop";

# Good
den.aspects.networking = { host, ... }: {
  nixos.networking.hostName = host.name;
};
```

---

## API Quick Reference

### den.lib.policy Effects

```nix
let inherit (den.lib) policy;

# Enrich current scope
policy.resolve { myFlag = true; }

# Create child entity scope
policy.resolve.to "user" { inherit host user; }

# Include an aspect
policy.include den.aspects.monitoring

# Provide a module to a class
policy.provide { class = "nixos"; module = { ... }; }

# Route content between scopes
policy.route "homeManager" [ "home-manager" "users" userName ]

# Exclude a policy
policy.exclude den.policies.blocked
```

### den.lib.policy.pipe

```nix
let inherit (den.lib.policy) pipe;

pipe.from "firewall"
pipe.filter (e: e.proto == "tcp")
pipe.transform (b: "${b.addr}:${toString b.port}")
pipe.as "monitoring-targets"
pipe.expose
pipe.collect ({ host, ... }: true)
pipe.broadcast
```

### den.lib.policy Conditional

```nix
den.lib.policy.for den.hosts.x86_64-linux.igloo den.policies.my-policy
den.lib.policy.when ({ host, ... }: host.wsl.enable) den.policies.wsl-support
```

---

## Related Skills

- **den-flake-parts-integration** — Setting up Den with flake-parts
- **den-aspect-development** — Writing and organizing aspects
- **den-batteries-and-ecosystem** — Reusable aspect providers
- **den-effects-and-pipeline** — Internal mechanics and debugging
- **den-migration-and-best-practices** — Migration from legacy setups
- **den-api-reference** — Complete API lookup

---

## Further Reading

- [Den Documentation](https://github.com/denful/den)
- [flake-aspects](https://github.com/denful/flake-aspects) — Dependency-free library Den builds upon
- [nix-effects](https://github.com/denful/nix-effects) — Algebraic effects library
- [dendrix](https://dendrix.denful.dev) — Aspect index/repository
- [gen](https://gen.wtf) — Graph-based libraries (future foundation)

---

## Key Takeaways

1. **Four concerns**: Entity (what exists), Aspect (what it does), Policy (how they relate), Quirk (structured data)
2. **Aspects are functions** — parametric dispatch replaces `mkIf`
3. **Composition via includes** — DAG through includes, tree through nesting
4. **Batteries are reusable aspect providers** — opt-in or auto-activated
5. **Quirks decouple** — producers and consumers don't know about each other
6. **Zero lock-in** — works with or without flakes, flake-parts, or home-manager
7. **Extensible** — custom classes, entity kinds, and pipelines
