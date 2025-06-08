{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.system.net.tools.speedtest;
in {
  options = {
    modules.system.net.tools.speedtest = {
      enable = lib.mkEnableOption "Enable Speedtest.";
    };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.speedtest-rs
    ];
  };
}
