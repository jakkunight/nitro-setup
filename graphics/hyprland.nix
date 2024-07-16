# Hyprland systemwide config:
{ pkgs, lib, configs, inputs, ... }:
{
  # Install extra packages:
  environment.systemPackages = with pkgs; [
    # Use Dunst for notifications:
    dunst
    # Required to build Hyprland:
    hyprutils
    hyprland
    hyprlang
    swww # To set the wallpaper (later).
  ];
  # Enable Hyprland:
  programs.hyprland = {
    enable = true;
  };

  # For Electron apps:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
