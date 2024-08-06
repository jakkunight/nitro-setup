# Full config:
{config, lib, pkgs, ...}@inputs:
{
  imports = [
    ./hyprland.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./wofi.nix
    ./waybar.nix
  ];
}
