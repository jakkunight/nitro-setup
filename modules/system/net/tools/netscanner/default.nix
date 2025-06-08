{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.system.net.tools.netscanner;
in {
  options = {
    modules.system.net.tools.netscanner = {
      enable = lib.mkEnableOption "Enable NetScanner.";
    };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.netscanner
    ];
  };
}
