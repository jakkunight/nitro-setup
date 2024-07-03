# Here goes my Hyprland setup:
{ config, lib, pkgs, ... }@inputs: {
  # Display Manager:
  services.xserver.displayManager.gdm.enable = true;
  
  # Swaylock:
  environment.systemPackages = with pkgs; [
    dunst
    swaylock
  ];
  security.pam.services.swaylock = {};
  
  programs.hyprland = {
    enable = true;
  };
}
