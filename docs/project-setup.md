# Project Setup

## Dendritic Nix

Dendritic is a pattern for writing nix configurations based on flake-parts's
modules option.

We say that Dendritic nix configurations are aspect-oriented, meaning that each
nix file provides config-values for the same aspect across different nix
configuration classes.

Normally, this is done via flake-parts' flake.modules.<class>.<aspect> options.

Where <class> is a type of configuration, like nixos, darwin, homeManager,
nixvim, etc.

And <aspect> is the cross-cutting concern or feature that is being configured
across one or more of these classes.

> Dendritic is a configuration pattern - a way-of-doing-. Not a library nor a
> framework.
