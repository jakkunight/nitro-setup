{
  inputs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types;
in {
  # Helper function to make hosts:
  # hosts := {
  #   hostname := {
  #     system := Enum["x86_64-linux", "aaarch64-linux"];
  #     users := {
  #       username := List[module1, module2, ...];
  #     };
  #   };
  # };

  options = {
    nixosHosts = let
      userModules = types.submodule {
        options = {
          modules = mkOption {
            type = types.listOf (types.attrs);
            default = {};
          };
        };
      };
      nixosHostType = types.submodule {
        options = {
          system = mkOption {
            type = types.enum [
              "x86_64-linux"
            ];
            default = "x86_64-linux";
          };
          users = types.attrsOf userModules;
        };
      };
    in
      mkOption {
        type = types.attrsOf nixosHostType;
      };
  };
  config = {
    flake.nixosConfigurations = let
      mkHost = hostname: { system, userModules }: inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = (builtins.mapAttrs);
      };
       in {}
  };
}
