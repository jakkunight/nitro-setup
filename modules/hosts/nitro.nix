{
  inputs,
  config,
  lib,
  ...
}: {
  nixosHosts.nitro = {
    system = "x86_64-linux";
    users = {
      jakku = let
        systemModules = with config.flake.modules.nixos; [];
        homeModules = with config.flake.modules.home; [];
      in
        homeModules + systemModules;
    };
  };
}
