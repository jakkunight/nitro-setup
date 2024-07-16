# X11 config:
{ ... }:
{
  # Enable X11:
  services.xserver = {
    enable = true;
    desktopManager.xfce.enable = true;
  };
}
