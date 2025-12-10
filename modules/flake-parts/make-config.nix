{
  lib,
  config,
  inputs,
  ...
}: let
  # inherit (lib) types mkOption;
in {
  options = let
  in {
  };
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.home-manager.flakeModules.home-manager
  ];
  config = {
    flake = let
      mkFlakeConfig = {
        hostname,
        username,
        homename,
      }: options: let
        nixpkgs' =
          if options.nixosHosts.${hostname}.unstable
          then inputs.nixpkgs
          else inputs.nixpkgs-stable;
        home-manager' =
          if options.nixosHosts.${hostname}.unstable
          then inputs.home-manager
          else inputs.home-manager-stable;
      in {
        nixosConfigurations.${hostname} = nixpkgs'.lib.nixosSystem {
          inherit (options.nixosHosts.${hostname}) system;
          modules = [
            {
              users.users.${username} = {
                initialPassword = "${username}";
                inherit (options.nixosUsers.${username}) isNormalUser extraGroups shell;
              };
              system = {
                inherit (options.nixosHosts.${hostname}) stateVersion;
              };
            }
          ];
        };
        homeConfigurations.${homename} = let
          pkgs = nixpkgs'.legacyPackages.${options.nixosHosts.${hostname}.system};
        in
          home-manager'.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              {
                home = {
                  inherit username;
                  homeDirectory =
                    if options.nixosUsers.${username}.isNormalUser
                    then "/home/${username}"
                    else throw "The user must be normal user to have a $HOME directory! Please review your user configuration options and set `options.nixosUsers.${username}.isNormalUser = true`";
                  inherit (options.nixosHosts.${hostname}) stateVersion;
                };
                programs.home-manager.enable = true;
              }
            ];
          };
      };
    in
      lib.mapAttrs mkFlakeConfig config.flakeConfigs;
  };
}
