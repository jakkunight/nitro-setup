# Developmant utilities:
{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nix-ld
    envfs
    cachix
    devenv
    devbox
  ];
}
