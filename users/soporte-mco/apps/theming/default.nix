# Full theming config:
{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ./qt.nix
    ./gtk.nix
  ];
}
