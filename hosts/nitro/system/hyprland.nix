# Here goes my Hyprland setup:
{ config, lib, pkgs, ... }@inputs: {
  # Display Manager:
  services.displayManager.sddm.enable = true;

  # Swaylock:
  environment.systemPackages = with pkgs; [
    dunst
    swaylock
    hyprlock
    hyprpaper
    hypridle
    hyprcursor
    hyprnotify
  ];
  security.pam.services.swaylock = { };

  programs.hyprland = {
    enable = true;
  };
}
