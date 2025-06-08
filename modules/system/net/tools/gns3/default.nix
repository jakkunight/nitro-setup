{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.system.net.tools.gns3;
in {
  options = {
    modules.system.net.tools.gns3 = {
      enable = lib.mkEnableOption "Enable GNS3.";
    };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.gns3
    ];
  };
}
