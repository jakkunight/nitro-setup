# Scripts

This folder contains all the custom scripts for making the system more modular
and clean.

Scripts **MUST** be defined by using `nix pkgs.writeShellScriptApplication` et
al.

## Example

```nix
{pkgs, inputs, ...}: pkgs.writeShellApplication {
  # The script binary name
  name = "";

  # The packages available at runtime:
  runtimeInputs = with pkgs; [];

  # Some options for checking the script syntax
  bashOptions = [];

  # The actual script
  text = '''';
}
```

You can easily get the binary path with:

```nix
lib.getExe (import ./my-script.nix {inherit pkgs; ... })}
```

The can also be installed into your system with:

```nix
# configuration.nix
{
  environment.systemPackages = [
    (import ./my-script.nix {inherit pkgs; ... })
  ];
}
```

Or using Home-Manager:

```nix
# configuration.nix
{
  home.packages = [
    (import ./my-script.nix {inherit pkgs; ... })
  ];
}
```
