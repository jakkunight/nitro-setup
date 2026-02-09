# Packages and Derivations

Here are the packages and derivations included with my own config.

This can also be used to bundle some assets within a custom ISO installer.

## Examples

You can build a derivation as follows:

```nix
# default.nix
{pkgs}: (
  pkgs.mkDerivation {
    # The package name
    name = "";
    # The path to the source code
    src = ./.;
    # Set this to `true` if not building a program, to skip the `buildPḧase`
    dontBuild = false;
    # Set this to `true` if you don't want to unpack the source by default
    dontUnpack = false;
    # Build dependencies
    buildInputs = with pkgs; [];
    # RuntimeDependencies
    nativeBuildInputs = with pkgs; [];
    # The script to build the package
    buildPhase = '''';
    # The script to install the package
    installPhase = ''
      # Always starts creating the output directory, which is managed by Nix.
      mkdir -p $out
      # ...
    '';
    # Project metadata
    meta = {
      # Homepage URL
      homepage = "";
      # Project description
      description = "";
      # Mantainers
      maintainers = [ ];
      # The license to use
      license = [ lib.licenses.mit ];
    };
  }
)
```
