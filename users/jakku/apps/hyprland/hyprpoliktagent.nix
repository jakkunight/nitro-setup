{ config, pkgs, inputs, ... }:
{
  environment.systemPackages = [
    pkgs.hyprpolkitagent
  ];
}
