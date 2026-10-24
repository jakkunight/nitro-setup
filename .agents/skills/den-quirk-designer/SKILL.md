---
name: den-quirk-designer
description: Design and implement quirks and pipes for cross-cutting concerns in Den Framework configurations.
---

# Den Quirk Designer

**Skill ID**: `den-quirk-designer`
**Version**: 1.0
**Category**: Cross-Cutting Concerns / Data Routing

## Description

Design and implement quirks and pipes for cross-cutting concerns in Den Framework configurations. This skill covers structured data sharing between aspects without coupling, enabling producers, consumers, and architects to collaborate through a decoupled data pipeline.

## Purpose

Quirks and pipes solve the fundamental problem of **sharing structured data between aspects without tight coupling**. They enable:

- **Decoupled data sharing**: Multiple aspects contribute data that a single consumer assembles
- **Cross-entity data flow**: Data flows across host, user, and home boundaries
- **Pipeline-time filtering**: Transform, filter, and route data through pipe stages
- **Scope-local defaults**: Quirk data is scope-local by default, crossing boundaries only via explicit pipes
- **Config-dependent thunks**: Quirk values can depend on evaluated configuration

## Use Cases

| Use Case | Description |
|----------|-------------|
| Firewall port aggregation | Multiple services declare ports; one aspect assembles the firewall |
| Editor extension management | Language aspects emit extensions; editor aspect consumes them |
| Persistence declarations | Services declare paths to persist; impermanence aspect applies them |
| Cross-host service discovery | HTTP backends register endpoints; load balancer collects them |
| BGP peer identity | Hosts emit BGP identity; cluster collects and filters peers |
| Settings aggregation | Per-host tunables declared next to the aspect that reads them |

## Key Den Framework Concepts

### 1. Roles in the Quirk/Pipe System

| Role | Who | What |
|------|-----|------|
| **Producer** | Any aspect | Emits data on a named quirk key |
| **Architect** | Policy author | Declares pipes and routing |
| **Consumer** | Class module | Receives assembled data via function args |

### 2. Quirk Declaration

A quirk is a named data channel with a description:

```nix
den.quirks.firewall.description = "Firewall port declarations";
den.quirks.http-backends.description = "HTTP backend endpoints";
den.quirks.persist.description = "System paths to keep across reboots";
```

### 3. Data Emission (Producer)

Aspects emit structured data on quirk keys. Values can be static or parametric:

```nix
# Static emission
den.aspects.nginx.firewall = { ports = [ 80 443 ]; };

# Parametric emission (depends on evaluated config)
den.aspects.my-service.firewall = { config, ... }: {
  ports = [ config.services.my-service.port ];
};
```

### 4. Data Consumption (Consumer)

Aspects receive assembled data as function arguments:

```nix
den.aspects.networking.nixos = { firewall, lib, ... }: {
  networking.firewall.allowedTCPPorts =
    lib.concatMap (f: f.ports or []) firewall;
};
```

### 5. Pipes (Optional Routing)

Pipes transform, filter, and route quirk data between scopes:

```nix
# Filter TCP ports only
den.policies.filter-tcp = { host, ... }: let inherit (den.lib.policy) pipe; in
  [ (pipe.from "firewall" [
      (pipe.filter (e: e.proto == "tcp"))
    ])
  ];
```

### 6. Scoping Rules

- Quirk data is **scope-local** by default
- Each entity (host, user, home) has its own scope
- Nothing crosses scope boundaries by itself
- Children scopes don't see parent data unless exposed
- Sibling scopes never see each other's data

## Pipe Stages Reference

### Transform Stages

| Stage | Signature | Description |
|-------|-----------|-------------|
| `pipe.filter` | `predicate` | Remove entries not matching predicate |
| `pipe.transform` | `fn` | Map each entry to new value |
| `pipe.fold` | `fn init` | Reduce all entries to single value |
| `pipe.append` | `value` | Add synthetic entry |
| `pipe.for` | `vals` | Replace entire list |

### Routing Stages

| Stage | Signature | Description |
|-------|-----------|-------------|
| `pipe.as` | `targetPipeName` | Rename pipe output |
| `pipe.expose` | — | Push child to parent |
| `pipe.collect` | `predicate` | Harvest from siblings |
| `pipe.collectAll` | `predicate` | Harvest from all scopes |
| `pipe.broadcast` | `predicate` | Push to all matching scopes |
| `pipe.to` | `[aspects]` | Route to specific aspects |
| `pipe.withProvenance` | — | Tag entries with source |

## Implementation Patterns

### Pattern 1: Firewall Port Aggregation

**Problem**: Multiple services need to declare firewall ports without the firewall aspect knowing about each service.

```nix
# Step 1: Declare the quirk
den.quirks.firewall.description = "Firewall port declarations";

# Step 2: Each service emits its ports
den.aspects.nginx.firewall = { ports = [ 80 443 ]; };
den.aspects.postgres.firewall = { ports = [ 5432 ]; };

# Step 3: Firewall aspect consumes and assembles
den.aspects.firewall.nixos = { firewall, lib, ... }: {
  networking.firewall.allowedTCPPorts =
    lib.concatMap (f: f.ports or []) firewall;
};
```

### Pattern 2: Language Extension Management

**Problem**: Language aspects should declare their editor extensions; the editor aspect should consume them.

```nix
# Declare quirks
den.quirks.editor-extensions.description = "Editor extension packages";
den.quirks.editor-settings.description = "Editor settings attrsets";

# Language aspect emits
den.aspects.lang.go.homeManager = { pkgs, ... }: {
  programs.go.enable = true;
  home.packages = [ pkgs.gopls pkgs.gotools ];
};
den.aspects.lang.go.editor-extensions = { pkgs, ... }: [ pkgs.vscode-extensions.golang.go ];
den.aspects.lang.go.editor-settings = [ { "go.useLanguageServer" = true; } ];

# Editor aspect consumes
den.aspects.editor.vscode.homeManager =
  { editor-settings, editor-extensions, lib, ... }: {
    programs.vscode = {
      enable = true;
      profiles.default = {
        userSettings = lib.mkMerge editor-settings;
        extensions = lib.unique (lib.flatten editor-extensions);
      };
    };
  };
```

### Pattern 3: Persistence Declarations

**Problem**: Services declare what they need to persist; impermanence aspect applies it.

```nix
# Declare quirks
den.quirks.persist.description = "System paths to keep across reboots";
den.quirks.persistHome.description = "Home paths to keep across reboots";

# Service declares its data
den.aspects.docker = {
  nixos.virtualisation.docker.enable = true;
  persist.directories = [ "/var/lib/docker" ];
};

# Impermanence aspect consumes
den.aspects.impermanence.nixos = { persist, lib, ... }: {
  environment.persistence."/persist" = {
    directories = lib.unique (lib.concatMap (e: e.directories or [ ]) persist);
    files = lib.unique (lib.concatMap (e: e.files or [ ]) persist);
  };
};
den.aspects.impermanence.homeManager = { persistHome, lib, ... }: {
  home.persistence."/persist" = {
    directories = lib.unique (lib.concatMap (e: e.directories or [ ]) persistHome);
    files = lib.unique (lib.concatMap (e: e.files or [ ]) persistHome);
  };
};
```

### Pattern 4: Cross-Host Service Discovery

**Problem**: HTTP backends register endpoints; a load balancer collects them.

```nix
# Declare quirk
den.quirks.http-backends.description = "HTTP backend endpoints";

# Each host emits its backend
den.aspects.nginx.http-backends = { host, ... }: {
  inherit (host) addr;
  port = host.httpPort;
};

# Collect across fleet
den.policies.collect-backends = { host, ... }: let inherit (den.lib.policy) pipe; in
  [ (pipe.from "http-backends" [
      (pipe.collect ({ host, ... }: true))
    ])
];

# Load balancer consumes
den.aspects.haproxy.nixos = { http-backends, lib, ... }: {
  services.haproxy.config = /* generate config from backends */;
};
```

### Pattern 5: BGP Peer Identity

**Problem**: Hosts emit BGP identity; cluster collects and filters peers.

```nix
# Declare quirk
den.quirks.bgp-peers.description = "BGP identity of each host";

# Host emits BGP identity
den.aspects.bgp.bgp-peers = { host, ... }: {
  inherit (host) name addr asn cluster;
};

# Host collects peers
den.policies.host-bgp-peers = { host, ... }: let inherit (den.lib.policy) pipe; in
  [ (pipe.from "bgp-peers" [
      (pipe.collect ({ host, ... }: true))
    ])
];

# Cluster collects and filters
den.policies.cluster-bgp-peers = { cluster, ... }: let inherit (den.lib.policy) pipe; in
  [ (pipe.from "bgp-peers" [
      (pipe.collect ({ host, ... }: true))
      (pipe.filter (p: p.cluster == cluster.name))
    ])
];
```

### Pattern 6: Upward Flow (Expose)

**Problem**: Child scope data needs to flow to parent scope.

```nix
den.policies.expose-prefs = { host, user, ... }: let inherit (den.lib.policy) pipe; in
  [ (pipe.from "prefs" [ pipe.expose ])
  ];
```

### Pattern 7: Config-Dependent Thunks

**Problem**: Quirk values need to reference evaluated configuration.

```nix
den.aspects.my-service = {
  nixos.services.my-service.enable = true;
  firewall = { config, ... }: {
    ports = [ config.services.my-service.port ];
  };
};
```

## Best Practices

### 1. Keep Quirks Focused

Each quirk should represent a single cross-cutting concern:

```nix
# Good: focused quirk
den.quirks.firewall.description = "Firewall port declarations";

# Bad: too broad
den.quirks.all-services.description = "All service data";
```

### 2. Use Parametric Emission for Dynamic Values

When quirk values depend on evaluated config, use thunks:

```nix
# Good: config-dependent
den.aspects.service.firewall = { config, ... }: { ports = [ config.service.port ]; };

# Bad: hardcoded value
den.aspects.service.firewall = { ports = [ 8080 ]; };
```

### 3. Declare Quirks Before Using Them

Always declare the quirk key with a description before emitting or consuming:

```nix
# Good: declare first
den.quirks.my-data.description = "My data channel";
den.aspects.producer.my-data = { ... };
```

### 4. Use `lib.concatMap` for Collection

When consuming, use `lib.concatMap` to flatten collected data:

```nix
den.aspects.consumer.nixos = { data, lib, ... }: {
  result = lib.concatMap (d: d.items or []) data;
};
```

### 5. Use `pipe.collect` for Sibling Data

To collect data from sibling scopes, use `pipe.collect` with a predicate:

```nix
den.policies.collect-all = { host, ... }: let inherit (den.lib.policy) pipe; in
  [ (pipe.from "data" [ (pipe.collect ({ host, ... }: true)) ])
  ];
```

### 6. Use `pipe.filter` for Selective Routing

Filter collected data before passing to consumers:

```nix
den.policies.filter-selected = { host, ... }: let inherit (den.lib.policy) pipe; in
  [ (pipe.from "data" [
      (pipe.filter (e: e.active))
    ])
  ];
```

### 7. Use `pipe.withProvenance` for Debugging

When debugging data flow, tag entries with their source:

```nix
den.policies.tag-sources = { host, ... }: let inherit (den.lib.policy) pipe; in
  [ (pipe.from "data" [ (pipe.withProvenance) ])
  ];
```

### 8. Respect Scope Boundaries

Remember that quirk data is scope-local by default. Use pipes to cross boundaries:

```nix
# Child scope data stays local
den.aspects.child.my-data = { value = 42; };

# To expose to parent, use pipe.expose
den.policies.expose-child = { host, ... }: let inherit (den.lib.policy) pipe; in
  [ (pipe.from "my-data" [ pipe.expose ])
  ];
```

### 9. Use `pipe.withProvenance` for Debugging

When debugging data flow, tag entries with their source:

```nix
den.policies.tag-sources = { host, ... }: let inherit (den.lib.policy) pipe; in
  [ (pipe.from "data" [ (pipe.withProvenance) ])
  ];
```

### 10. Include Policies in Entity Topology

Add policies to the entity's includes to activate data routing:

```nix
den.schema.host.includes = [
  den.policies.collect-all
  den.policies.filter-selected
];
```

## Common Mistakes

### 1. Forgetting to Declare the Quirk

```nix
# WRONG: quirk not declared
den.aspects.producer.my-data = { value = 42; };

# RIGHT: declare first
den.quirks.my-data.description = "My data channel";
den.aspects.producer.my-data = { value = 42; };
```

### 2. Using Non-Parametric Args in Consumer

```nix
# WRONG: consumer doesn't receive quirk data
den.aspects.consumer.nixos = { lib, ... }: {
  result = [];  # no data to work with
};

# RIGHT: consumer receives quirk data as arg
den.aspects.consumer.nixos = { my-data, lib, ... }: {
  result = lib.concatMap (d: d.value or []) my-data;
};
```

### 3. Trying to Cross Scope Without Pipes

```nix
# WRONG: sibling scopes can't see each other's data
den.aspects.producer.my-data = { value = 42; };
den.aspects.consumer.nixos = { my-data, lib, ... }: { ... };  # my-data is empty

# RIGHT: use pipe.collect to cross scope
den.policies.collect-data = { host, ... }: let inherit (den.lib.policy) pipe; in
  [ (pipe.from "my-data" [ (pipe.collect ({ host, ... }: true)) ])
  ];
```

### 4. Home Manager on Host Aspect

```nix
# WRONG: host scope homeManager has nowhere to go
den.aspects.laptop.homeManager.programs.vim.enable = true;

# RIGHT: use provides.to-users
den.aspects.laptop.provides.to-users.homeManager.programs.vim.enable = true;
```

## Integration Instructions for Pi Coding Agent

### When to Use This Skill

Use this skill when:
- Designing cross-cutting concerns that span multiple aspects
- Implementing data aggregation patterns (firewall ports, persistence, etc.)
- Building service discovery or fleet-wide data collection
- Creating decoupled producer-consumer relationships
- Implementing settings or configuration aggregation

### Workflow

1. **Identify the cross-cutting concern**: What data needs to flow between aspects?
2. **Design the quirk**: Name the quirk, write a description, decide the data shape
3. **Implement producers**: Each aspect that contributes data emits on the quirk key
4. **Implement consumer**: The aspect that needs the data receives it as a function arg
5. **Add pipes (optional)**: If data needs filtering, transformation, or scope crossing
6. **Test with `den.lib.aspects.resolve`**: Verify data flows correctly

### Quick Reference Commands

```nix
# Resolve aspects for testing
den.lib.aspects.resolve "nixos" config

# Check aspect tree
den.lib.aspects.resolve "nixos" config

# Generate nh wrapper scripts
den.lib.nh.denPackages { fromFlake = true; } pkgs;
```

### Testing Pattern

```nix
# Test quirk data flow
test = den.lib.testScope {
  den.aspects.producer.my-data = { value = 42; };
  den.aspects.consumer.nixos = { my-data, lib, ... }: {
    result = lib.concatMap (d: d.value or []) my-data;
  };
  # Verify consumer receives data
  assert consumerResult.result == [ 42 ];
};
```

## Summary

Quirks and pipes are the backbone of Den Framework's decoupled architecture. They enable:

- **Producers** to emit data on named channels without knowing who consumes it
- **Architects** to define data routing through policies and pipe stages
- **Consumers** to receive assembled data through function arguments
- **Scopes** to maintain isolation while allowing explicit data flow through pipes

This pattern is essential for building maintainable, composable NixOS configurations that scale across fleets.
