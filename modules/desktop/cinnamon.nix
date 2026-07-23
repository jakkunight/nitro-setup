let
  feature = "cinnamon";
in
{
  flake.modules = {
    nixos.${feature} =
      { lib, ... }:
      {
        services.xserver = {
          enable = lib.mkForce true;
          desktopManager.cinnamon.enable = true;
        };
      };
  };
}
