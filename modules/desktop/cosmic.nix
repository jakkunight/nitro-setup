let
  feature = "cosmic";
in
{
  flake.modules = {
    nixos.${feature} = {
      services.desktopManager.cosmic.enable = true;
    };
  };
}
