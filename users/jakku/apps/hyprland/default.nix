# Full config:
{config, lib, pkgs, ...}@inputs:
{
  imports = [
    ./hyprland.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpoliktagent.nix
    ./hyprpaper.nix
    ./wofi.nix
    ./waybar.nix
  ];
}
