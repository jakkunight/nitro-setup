# SDDM config:
{ lib, config, pkgs, ... }: {
  options = {
    graphics.display-manager.sddm = {
      enable = lib.mkEnableOption "Enable SDDM";
    };
  };
  config = lib.mkIf config.graphics.display-manager.sddm.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland = {
        enable = true;
      };
    };
  };
}
