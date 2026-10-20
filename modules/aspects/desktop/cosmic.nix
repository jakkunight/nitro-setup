let
  feature = "cosmic";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos = {
    services.desktopManager.cosmic.enable = true;
  };

}
