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
        default = {};
      };
  };
  config = {
    flake.nixosConfigurations = let
      loadModulesForUser = username: modules: (
        # Load NixOS modules:
        # (username, modules[]) => loadedModules[];
        # Load user creation module:
        # (username) => userModule
        # Concat the modules:
        # (userModule, loadedModules[]) => userLoadedModules[];
        (builtins.map (module: config.flake.modules.nixos.${module} or {}))
        ++ [
          {
            imports = [
              inputs.home-manager.nixosModules.home-manager
            ];
            home-manager.users.${username}.imports =
              [
                ({osConfig, ...}: {
                  home.stateVersion = osConfig.system.stateVersion;
                })
              ]
              ++ (builtins.map (module: config.flake.modules.home.${module} or {}));
          }
        ]
      );
      mkHost = hostname: {
        system,
        user,
      }:
        inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          modules = lib.attrsets.attrValues (builtins.mapAttrs loadModulesForUser user);
        };
    in
      builtins.mapAttrs mkHost config.nixosHosts;
  };
}
