# Hyprland!
{ lib, config, inputs, pkgs, ... }: {
  imports = [];
  options = {
    graphics.wm.hyprland = {
      enable = lib.mkEnableOption "Enable Hyprland!";
      nvidia = {
        enable = lib.mkEnableOption "Enable Nvidia support.";
      };
    };
  };
  config = lib.mkIf config.graphics.wm.hyprland.enable {
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      withUWSM = true;
      xwayland = {
        enable = true;
      };
    };
    
    programs.uwsm.enable = true;

    programs.hyprlock.enable = true;

    services.hypridle.enable = true;

    environment.systemPackages = [
      # Default terminal emulator:
      pkgs.kitty

      # Status bar:
      pkgs.waybar

      # Application launcher:
      pkgs.wofi

      # Filemanager (GUI):
      pkgs.nemo

      # Multimedia:
      pkgs.vlc
      pkgs.loupe
      pkgs.firefox
      pkgs.brave

      # Notifications:
      pkgs.swaynotificationcenter

      # Authentication agent:
      pkgs.hyprpolkitagent

      # Network applet:
      pkgs.networkmanagerapplet

      # Bluetooth applet:
      pkgs.blueberry

      # Wallpapers:
      pkgs.hyprpaper

      # Lockscreen:
      pkgs.hyprlock

      # Idle daemon:
      pkgs.hypridle

    ] ++ (
      if config.graphics.wm.hyprland.nvidia.enable
      then [
        pkgs.egl-wayland
        pkgs.nvidia-vaapi-driver
      ]
      else []
    );

    # Nvidia support:
    environment.sessionVariables = lib.mkIf config.graphics.wm.hyprland.nvidia.enable {
      "LIBVA_DRIVER_NAME" = "nvidia";

      # Comment the following line if experimenting issues:
      "__GLX_VENDOR_LIBRARY_NAME" = "nvidia"; 
      "NVD_BACKEND" = "direct";

      # For Electron apps:
      "ELECTRON_OZONE_PLATFORM_HINT" = "auto";
    };
  };
}
