# Developmant utilities:
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nix-ld
    envfs
    cachix
    devenv
  ];
}
