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
        systemModules = with config.flake.nixos; [];
        homeModules = with config.flake.home; [];
      in
        homeModules + systemModules;
    };
  };
}
