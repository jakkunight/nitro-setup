let
  feature = "kde";
in
{
  flake.modules = {
    nixos.${feature} = {
      services.desktopManager.plasma6.enable = true;
    };
    homeManager.${feature} = {
    };
  };
}
