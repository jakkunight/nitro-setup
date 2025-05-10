{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.system.net.tools.wireless;
in {
  options = {
    modules.system.net.tools.wireless = {
      enable = lib.mkEnableOption "Enable WPA Supplicant.";
    };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.wpa_supplicant
    ];
  };
}
