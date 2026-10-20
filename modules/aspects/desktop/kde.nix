let
  feature = "kde";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos = {
      services.desktopManager.plasma6.enable = true;
    };
    homeManager = {
    };
  };

}
