---
name: den-cli-helper
description: Helper for Den CLI commands and nh wrapper scripts.
---

# Den CLI Helper

**Skill ID**: `den-cli-helper`
**Version**: 1.0
**Category**: CLI Tools / Build Automation / Workflow

## Description

Helper for Den CLI commands and `nh` wrapper scripts. This skill covers the command-line interface for building, testing, and managing Den Framework configurations efficiently from the terminal or as a Pi coding agent.

## Purpose

The Den CLI and `nh` wrapper scripts provide a streamlined workflow for building and managing Den Framework configurations. This skill covers:

- **Building configurations**: Using `den build` and `nh` wrappers to compile NixOS/Darwin systems
- **Testing configurations**: Running `den test` and `den lint` for validation
- **Managing entities**: Listing, resolving, and inspecting hosts, users, and homes
- **Generating wrappers**: Creating `nh` wrapper scripts for quick system operations
- **Diagram generation**: Using `den-diagram` to visualize configuration topology
- **Namespace management**: Creating scoped aspect libraries with `den.namespace`

## Use Cases

| Use Case | Description |
|----------|-------------|
| Quick system rebuild | Rebuild a host configuration with `nh os switch` |
| Fleet-wide testing | Test all hosts in a fleet with `den test` |
| Configuration inspection | Inspect resolved aspects for a host with `den inspect` |
| Diagram generation | Generate Mermaid diagrams from configuration with `den-diagram` |
| Namespace creation | Create scoped aspect libraries for team sharing |
| Wrapper script generation | Generate `nh` wrappers for team members |
| Linting configurations | Check for common mistakes and best practices |

## Key Den Framework Concepts

### 1. Den CLI Commands

The `den` CLI provides subcommands for working with Den Framework configurations:

```bash
# Build a specific host
 den build --flake .#nixosConfigurations.laptop

# Test a configuration
 den test --flake .#nixosConfigurations.laptop

# Lint the configuration
 den lint --flake .

# List all hosts in the flake
 den list --flake .

# Inspect resolved aspects for a host
 den inspect --flake .#nixosConfigurations.laptop
```

### 2. den.lib.aspects.resolve

Resolve an aspect for a given class. This is the primary way to inspect what configuration will be applied:

```nix
# Resolve the nixos class for the igloo host
 den.lib.aspects.resolve "nixos" den.aspects.igloo

# Resolve for a specific entity
 den.lib.aspects.resolve "nixos" (den.lib.resolveEntity "host" {
   host = den.hosts.x86_64-linux.igloo;
 });
```

### 3. den.lib.resolveEntity

Resolve an entity by kind, providing the fully resolved entity with all aspects applied:

```nix
# Resolve a host entity
 den.lib.resolveEntity "host" {
   host = den.hosts.x86_64-linux.igloo;
   ctx = { inherit host; };
 }

# Resolve a user entity
 den.lib.resolveEntity "user" {
   host = den.hosts.x86_64-linux.igloo;
   user = "alice";
 }
```

### 4. den.namespace

Create a scoped aspect library that can be shared across flakes:

```nix
# Create an exported namespace
 den.namespace "myns" true

# Create a local namespace
 den.namespace "myns" false

# Create a namespace that imports from upstream
 den.namespace "shared" [ inputs.team-config ]
```

### 5. den-diagram CLI

Generate diagrams from Den configuration in multiple formats:

```bash
# Generate Mermaid diagram
 den-diagram mermaid --flake .

# Generate DOT graph
 den-diagram dot --flake .

# Generate PlantUML
 den-diagram plantuml --flake .

# Generate C4 component diagram
 den-diagram c4 --flake .

# Generate Sankey diagram
 den-diagram sankey --flake .

# Generate treemap
 den-diagram treemap --flake .

# Generate mindmap
 den-diagram mindmap --flake .

# Generate JSON
 den-diagram json --flake .
```

### 6. den.lib.nh - Wrapper Script Generation

Generate `nh` wrapper scripts for quick system operations:

```nix
# Generate denPackages (full nh wrapper scripts)
 den.lib.nh.denPackages { fromFlake = true; } pkgs

# Generate denShell (development shell with nh)
 den.lib.nh.denShell { fromFlake = false; outPrefix = [ "flake" ]; } pkgs

# Generate denApps (NixOS application entries)
 den.lib.nh.denApps args pkgs

# Generate hostApps (host-specific application entries)
 den.lib.nh.hostApps args pkgs

# Generate homeApps (home-manager application entries)
 den.lib.nh.homeApps args pkgs
```

### 7. den.lib.schema - Type Checking

Use schema utilities for type checking and strict mode:

```nix
# Create a strict instance type from a schema
 den.lib.schema.mkInstanceType {
   strict = den.schema.user.isStrict;
   extraModules = [ ];
 } den.schema.user;
```

### 8. den.lib.policy - Policy Resolution

Resolve and manipulate policies programmatically:

```nix
# Resolve a policy for enriched context
 den.lib.policy.resolve { enriched = true; }

# Resolve to a specific target
 den.lib.policy.resolve.to "user" { inherit host user; }

# Resolve shared policy
 den.lib.policy.resolve.shared { inherit user; }

# Route from one class to another
 den.lib.policy.route {
   fromClass = "myClass";
   intoClass = "nixos";
   path = [ "services" "myService" ];
 }
```

## Example Nix Code Snippets

### Example 1: Complete Flake with CLI Integration

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
            ({ den, ... }: {
              den.hosts.x86_64-linux.laptop = {
                users.alice = { };
              };
              den.default = {
                nixos.system.stateVersion = "25.11";
                homeManager.home.stateVersion = "25.11";
                includes = [
                  den.batteries.define-user
                  den.batteries.hostname
                ];
              };
            })
          ];
        };
      };

      # Generate nh wrapper scripts
      nhWrappers = den.lib.nh.denPackages { fromFlake = true; } pkgs;
    };
}
```

### Example 2: Generating Diagrams

```nix
# Capture fleet configuration
let
  diagram = den.lib.capture.captureFleet { };
in
  diagram.toMermaid g  # Returns Mermaid syntax
  diagram.toDot g      # Returns DOT graph syntax
  diagram.toPlantUML g # Returns PlantUML syntax
  diagram.toC4Component g  # Returns C4 component diagram
  diagram.toSankeyMermaid g  # Returns Sankey diagram
  diagram.toTreemapMermaid g # Returns treemap diagram
  diagram.toMindmapMermaid g # Returns mindmap diagram
  diagram.toJSON g     # Returns JSON representation
```

### Example 3: Namespace for Team Sharing

```nix
{
  # Create a shared namespace
  den.namespace "team" [ inputs.team-config ];

  # Use the namespace in configurations
  den.aspects.team-tools = {
    includes = [ (den.namespace "team" true) ];
    nixos = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.git pkgs.neovim ];
    };
  };
}
```

### Example 4: Policy Resolution for Debugging

```nix
# Resolve all policies for a host
let
  host = den.lib.resolveEntity "host" {
    host = den.hosts.x86_64-linux.laptop;
  };
in
  # Get resolved aspects
  den.lib.aspects.resolve "nixos" host.aspects

  # Resolve with enrichment
  den.lib.policy.resolve { enriched = true; }

  # Route specific class content
  den.lib.policy.route {
    fromClass = "nixos";
    intoClass = "myClass";
    path = [ "services" ];
  }
```

### Example 5: Schema Type Checking

```nix
# Create strict schema for users
den.schema.user = den.lib.schema.mkInstanceType {
  strict = den.schema.user.isStrict;
  extraModules = [ ];
} den.schema.user;

# Create strict schema for hosts
den.schema.host = den.lib.schema.mkInstanceType {
  strict = true;
  extraModules = [ ];
} den.schema.host;
```

### Example 6: Policy Pipe Operations

```nix
let inherit (den.lib.policy) pipe;

den.policies.filter-firewall = { host, ... }: [
  (pipe.from "firewall" [
    (pipe.filter (e: e.proto == "tcp"))
    (pipe.transform (e: { port = e.port; }))
  ])
];

den.policies.collect-firewall = { host, ... }: [
  (pipe.from "firewall" [
    (pipe.collect ({ host, ... }: true))
    (pipe.collectAll ({ host, ... }: true))
  ])
];

den.policies.broadcast-firewall = { host, ... }: [
  (pipe.from "firewall" [
    (pipe.broadcast ({ host, ... }: true))
    (pipe.withProvenance)
  ])
];
```

## CLI Command Reference

### den CLI Subcommands

| Command | Description | Example |
|---------|-------------|---------|
| `den build` | Build a NixOS/Darwin configuration | `den build --flake .#nixosConfigurations.laptop` |
| `den test` | Test a configuration | `den test --flake .#nixosConfigurations.laptop` |
| `den lint` | Lint the flake configuration | `den lint --flake .` |
| `den list` | List all entities in the flake | `den list --flake .` |
| `den inspect` | Inspect resolved aspects | `den inspect --flake .#nixosConfigurations.laptop` |
| `den namespace` | Create a scoped aspect library | `den.namespace "myns" true` |

### den-diagram Formats

| Format | Command | Output |
|--------|---------|--------|
| Mermaid | `den-diagram mermaid` | Mermaid syntax |
| DOT | `den-diagram dot` | Graphviz DOT |
| PlantUML | `den-diagram plantuml` | PlantUML syntax |
| C4 | `den-diagram c4` | C4 component diagram |
| Sankey | `den-diagram sankey` | Sankey diagram |
| Treemap | `den-diagram treemap` | Treemap diagram |
| Mindmap | `den-diagram mindmap` | Mindmap diagram |
| JSON | `den-diagram json` | JSON representation |

### nh Wrapper Scripts

| Script | Description | Usage |
|--------|-------------|-------|
| `nh os switch` | Switch to a NixOS configuration | `nh os switch` |
| `nh os build` | Build a NixOS configuration | `nh os build` |
| `nh os test` | Test a NixOS configuration | `nh os test` |
| `nh home switch` | Switch home-manager configuration | `nh home switch` |
| `nh home build` | Build home-manager configuration | `nh home build` |

## Best Practices

### 1. Use `fromFlake = true` for Wrapper Scripts

When generating `nh` wrapper scripts, use `fromFlake = true` to ensure the scripts reference the correct flake:

```nix
# Good: references the flake correctly
den.lib.nh.denPackages { fromFlake = true; } pkgs

# Bad: may not reference the flake correctly
den.lib.nh.denPackages { fromFlake = false; } pkgs
```

### 2. Generate Diagrams for Debugging

Use `den-diagram` to visualize configuration topology when debugging:

```bash
# Generate a Mermaid diagram for documentation
den-diagram mermaid --flake . > docs/config-diagram.md

# Generate a JSON diagram for programmatic analysis
den-diagram json --flake . | jq '.edges' > debug-edges.json
```

### 3. Use `den inspect` for Debugging

When a configuration isn't working as expected, use `den inspect` to see what's being resolved:

```bash
# Inspect the full resolved configuration
den inspect --flake .#nixosConfigurations.laptop

# Inspect specific aspects
den inspect --flake . --aspect den.aspects.laptop
```

### 4. Use `den lint` for Best Practices

Run `den lint` before committing changes to catch common mistakes:

```bash
# Lint the entire flake
den lint --flake .

# Lint with verbose output
den lint --flake . --verbose
```

### 5. Use `den test` Before Building

Always test configurations before building in production:

```bash
# Test a specific host
den test --flake .#nixosConfigurations.laptop

# Test all hosts
den test --flake .
```

### 6. Keep Wrapper Scripts in the Flake

Generate wrapper scripts as part of the flake outputs so they're versioned and reproducible:

```nix
{
  outputs = { den, nixpkgs, ... }: {
    packages.x86_64-linux.nhWrappers =
      den.lib.nh.denPackages { fromFlake = true; } pkgs;
  };
}
```

### 7. Use Namespaces for Team Sharing

When sharing aspects across flakes, use `den.namespace` to create scoped libraries:

```nix
# Create an exported namespace
den.namespace "shared" true

# Create a namespace with upstream imports
den.namespace "team" [ inputs.team-config ]
```

### 8. Use Policy Resolution for Dynamic Config

When you need to dynamically resolve policies, use `den.lib.policy.resolve`:

```nix
# Resolve with enrichment for full context
den.lib.policy.resolve { enriched = true; }

# Resolve to a specific target
den.lib.policy.resolve.to "user" { inherit host user; }
```

## Common Patterns

### Pattern 1: Quick System Rebuild

```bash
# Using nh wrapper
nh os switch

# Using den CLI directly
den build --flake .#nixosConfigurations.laptop
```

### Pattern 2: Fleet-Wide Testing

```bash
# Test all hosts in the flake
den test --flake .

# Test with verbose output
den test --flake . --verbose
```

### Pattern 3: Configuration Diagram

```bash
# Generate a Mermaid diagram for documentation
den-diagram mermaid --flake . > docs/config.md

# Generate a JSON diagram for analysis
den-diagram json --flake . > config.json
```

### Pattern 4: Namespace-Based Team Config

```nix
# In team flake
outputs = { den, ... }: {
  den.namespace "team" true;
  den.aspects.team-tools = { /* ... */ };
};

# In user flake
inputs = {
  team-config.url = "github:team/config";
};

# In modules
modules = [
  ({ den, ... }: {
    den.aspects.my-host.includes = [
      (den.namespace "team" [ inputs.team-config ])
    ];
  })
];
```

### Pattern 5: Policy-Based Dynamic Routing

```nix
# In policies
let inherit (den.lib.policy) pipe;

den.policies.dynamic-routing = { host, ... }: [
  (pipe.from "services" [
    (pipe.filter (e: e.active))
    (pipe.transform (e: { route = e.path; }))
    (pipe.collect ({ host, ... }: true))
  ])
];
```

## Common Mistakes

### 1. Forgetting `fromFlake = true`

```nix
# WRONG: wrapper may not reference the flake
den.lib.nh.denPackages { fromFlake = false; } pkgs

# RIGHT: always use fromFlake = true for wrapper scripts
den.lib.nh.denPackages { fromFlake = true; } pkgs
```

### 2. Using `den build` Without Testing First

```bash
# WRONG: build without testing
den build --flake .#nixosConfigurations.laptop

# RIGHT: test before building
den test --flake .#nixosConfigurations.laptop
den build --flake .#nixosConfigurations.laptop
```

### 3. Not Using `den inspect` for Debugging

```bash
# WRONG: guessing what's wrong
den build --flake .#nixosConfigurations.laptop  # fails

# RIGHT: inspect first
den inspect --flake .#nixosConfigurations.laptop
```

### 4. Missing `den lint` Before Committing

```bash
# WRONG: commit without linting
git commit -m "Update config"

# RIGHT: lint before committing
den lint --flake .
git commit -m "Update config"
```

### 5. Forgetting to Include Batteries for Wrapper Scripts

```nix
# WRONG: wrapper scripts may not work
den.lib.nh.denPackages { fromFlake = true; } pkgs

# RIGHT: include batteries for full functionality
den.default.includes = [
  den.batteries.define-user
  den.batteries.hostname
];
den.lib.nh.denPackages { fromFlake = true; } pkgs
```

## Integration Instructions for Pi Coding Agent

### When to Use This Skill

Use this skill when:
- Building or testing NixOS/Darwin configurations from the terminal
- Generating `nh` wrapper scripts for quick system operations
- Creating diagrams to visualize configuration topology
- Debugging configuration issues with `den inspect`
- Creating scoped aspect libraries with `den.namespace`
- Resolving policies and entities programmatically
- Linting configurations for best practices

### Workflow

1. **Identify the task**: Build, test, lint, inspect, or diagram?
2. **Choose the right command**: Use the CLI reference table above
3. **Execute the command**: Run the appropriate `den` or `den-diagram` command
4. **Verify the result**: Check output for errors or unexpected behavior
5. **Iterate**: Use `den inspect` to debug if something isn't working

### Quick Reference Commands

```bash
# Build a host
den build --flake .#nixosConfigurations.<host>

# Test a host
den test --flake .#nixosConfigurations.<host>

# Lint the flake
den lint --flake .

# List all hosts
den list --flake .

# Inspect a host
den inspect --flake .#nixosConfigurations.<host>

# Generate Mermaid diagram
den-diagram mermaid --flake .

# Generate JSON diagram
den-diagram json --flake .
```

### Nix Code Reference

```nix
# Resolve an aspect
den.lib.aspects.resolve "nixos" den.aspects.igloo

# Resolve an entity
den.lib.resolveEntity "host" { host = den.hosts.x86_64-linux.igloo; }

# Create a namespace
den.namespace "myns" true

# Generate wrapper scripts
den.lib.nh.denPackages { fromFlake = true; } pkgs

# Generate shell
den.lib.nh.denShell { fromFlake = false; outPrefix = [ "flake" ]; } pkgs

# Policy resolution
den.lib.policy.resolve { enriched = true; }

# Schema type checking
den.lib.schema.mkInstanceType {
  strict = den.schema.user.isStrict;
  extraModules = [ ];
} den.schema.user;
```

### Testing Pattern

```bash
# Test before building
den test --flake .#nixosConfigurations.laptop

# Test with verbose output
den test --flake .#nixosConfigurations.laptop --verbose

# Test all hosts
den test --flake .
```

## Summary

The Den CLI and `nh` wrapper scripts provide a powerful command-line interface for building, testing, and managing Den Framework configurations. This skill covers:

- **CLI commands**: `den build`, `den test`, `den lint`, `den inspect`, `den list`
- **Diagram generation**: `den-diagram` with multiple output formats
- **Wrapper scripts**: `den.lib.nh.denPackages` for quick system operations
- **Entity resolution**: `den.lib.resolveEntity` and `den.lib.aspects.resolve`
- **Namespace management**: `den.namespace` for team sharing
- **Policy resolution**: `den.lib.policy.resolve` for dynamic configuration
- **Schema utilities**: `den.lib.schema.mkInstanceType` for type checking

This skill is essential for efficiently working with Den Framework configurations from the terminal or as a Pi coding agent.
