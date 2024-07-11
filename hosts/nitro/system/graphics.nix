# Here goes any graphic related config:
{ config, lib, pkgs, ... }@inputs: {
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = false;
  services.xserver.desktopManager.xfce.enable = true;

  # Hyprland:
  imports = [
    ./hyprland.nix
  ];
}
