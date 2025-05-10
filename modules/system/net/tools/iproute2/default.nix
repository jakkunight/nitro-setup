{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.system.net.tools.iproute2;
in {
  options = {
    modules.system.net.tools.iproute2 = {
      enable = lib.mkEnableOption "Enable IP Route2 tools.";
    };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.iproute2
    ];
  };
}
