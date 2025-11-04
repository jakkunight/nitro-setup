{pkgs, ...}: {
  services.xserver.desktopManager.xfce = {
    enable = true;
    enableXfwm = true;
  };
}
