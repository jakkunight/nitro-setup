_: let
  moduleName = "desktop/cinnamon";
in {
  flake.modules = {
    nixos.${moduleName} = _: {
      services.xserver.desktopManager.cinnamon.enable = true;
    };
  };
}
