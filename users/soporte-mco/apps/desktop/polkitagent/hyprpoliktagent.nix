{ config, pkgs, inputs, ... }:
{
  home.packages = [
    pkgs.hyprpolkitagent
  ];
}
