# Netscanner:
{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    terminal.utils.netscanner = {
      enable = lib.mkEnableOption "Enable Netscanner.";
    };
  };
  config = lib.mkIf config.terminal.utils.netscanner.enable {
    environment.systemPackages = [
      pkgs.netscanner
    ];
  };
}
