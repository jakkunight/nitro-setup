# Web Browsers:
{config, lib, pkgs, ...}@inputs:
{
  imports = [
    ./firefox.nix
    ./brave.nix
  ];
}
