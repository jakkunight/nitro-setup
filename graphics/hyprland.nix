# Hyprland systemwide config:
{ pkgs, ... }:
{
  # Enable Hyprland:
  programs.hyprland.enable = true;

  # Install dunst:
  environment.systemPackages = with pkgs; [
    dunst
  ];
}
