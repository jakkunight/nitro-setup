_: {
  services.xserver.enable = true;
  services.xserver.desktopManager.xfce = {
    enable = true;
    enableXfwm = true;
  };
  # Since I use SDDM:
  services.xserver.displayManager.lightdm.enable = false;
}
