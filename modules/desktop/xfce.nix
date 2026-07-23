let
  feature = "xfce";
in
{
  flake.modules = {
    nixos.${feature} = {
      services.xserver.desktopManager.xfce = {
        enable = true;
        enableScreensaver = true;
        enableWaylandSession = true;
      };
    };
  };
}
