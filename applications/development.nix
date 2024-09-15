# Developmant utilities:
{ config, lib, pkgs, ... } @ inputs:
{
  environment.systemPackages = [
    pkgs.nix-ld
    pkgs.cachix
    pkgs.devenv
    pkgs.direnv
    pkgs.cargo-binutils
  ];
}
