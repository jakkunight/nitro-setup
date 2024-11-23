# Full config:
{config, lib, pkgs, ...}@inputs:
{
  imports = [
    ./hyprland.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./wofi.nix
    ./waybar.nix
  ];
}
