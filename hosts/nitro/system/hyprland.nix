# Here goes my Hyprland setup:
{ config, lib, pkgs, ... }@inputs: {
  # Display Manager:
  services.displayManager = {
    sddm.enable = true;
    defaultSession = "hyprland";
    sddm.wayland.enable = true;
  };
  
  # Swaylock:
  environment.systemPackages = with pkgs; [
    swaylock
  ];

  security.pam.services.swaylock = {};
  
  programs.hyprland = {
    enable = true;
  };
}
