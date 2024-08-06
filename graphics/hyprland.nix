# Hyprland systemwide config:
{ pkgs, lib, configs, inputs, ... }:
{
  # Install extra packages:
  environment.systemPackages = with pkgs; [
    # Use Dunst for notifications:
    dunst
    waybar
    swww # To set the wallpaper (later).
    wl-clipboard
    wl-clipboard-rs
    wl-mirror
    wl-clipboard-x11
    hyprshot
  ];
  # Enable Hyprland:
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };

  # For Electron apps:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
