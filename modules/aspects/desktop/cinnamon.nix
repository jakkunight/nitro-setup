let
  feature = "cinnamon";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos =
    { lib, ... }:
    {
      services.xserver = {
        enable = lib.mkForce true;
        desktopManager.cinnamon.enable = true;
      };
    };

}
