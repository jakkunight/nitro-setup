_: {
  programs.windowManager.hyprland.settings = {
    xwayland = {
      force_zero_scaling = true;
    };
    env = [
      "LIBVA_DRIVER_NAME,nvidia"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "ELECTRON_OZONE_PLATFORM_HINT,auto"
      "NVD_BACKEND,direct"
    ];
    monitor = [
      "eDP-1,preferred,auto,1"
      ",preferred,auto,1,mirror"
    ];
  };
}
