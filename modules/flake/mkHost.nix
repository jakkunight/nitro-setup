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
      userConfig = types.submodule {
        options = {
          extraGroups = mkOption {
            type = types.listOf types.str;
            default = [];
          };
        };
      };
      userModules = types.submodule {
        options = {
          modules = mkOption {
            type = types.listOf (types.nonEmptyStr);
            default = [];
          };
          userConfig = mkOption {
            type = userConfig;
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
          users = mkOption {
            type = types.attrsOf userModules;
            default = [];
          };
        };
      };
    in
      mkOption {
        type = types.attrsOf nixosHostType;
      };
  };
  config = {
    flake.nixosConfigurations = let
      loadHomeModules = modules: (builtins.map (module: (config.flake.modules.homeManager.${module} or {})) modules);
      loadNixosModules = modules: (builtins.map (module: (config.flake.modules.nixos.${module} or {})) modules);
      loadModulesForUser = username: {
        userConfig,
        modules,
      }: (
        # Load NixOS modules:
        # (username, modules[]) => loadedModules[];
        # Load user creation module:
        # (username) => userModule
        # Concat the modules:
        # (userModule, loadedModules[]) => userLoadedModules[];
        (loadNixosModules modules)
        ++ [
          (_: {
            imports = [
              inputs.home-manager.nixosModules.home-manager
            ];
            users.users.${username} = {
              isNormalUser = true;
              initialPassword = "${username}";
              extraGroups = userConfig.extraGroups;
            };
            home-manager.users.${username}.imports =
              [
                ({osConfig, ...}: {
                  home.stateVersion = "${osConfig.system.stateVersion}";
                })
              ]
              ++ (loadHomeModules modules);
          })
        ]
      );
      mkHost = hostname: {
        system,
        users,
      }:
        inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          modules = lib.lists.flatten (lib.attrsets.attrValues (builtins.mapAttrs loadModulesForUser users));
        };
    in
      builtins.mapAttrs mkHost config.nixosHosts;
  };
}
