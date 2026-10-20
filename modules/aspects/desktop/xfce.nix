let
  feature = "xfce";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos = {
    services.xserver.desktopManager.xfce = {
      enable = true;
      enableScreensaver = true;
      enableWaylandSession = true;
    };
  };

}
