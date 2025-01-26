# Speedtest-rs, a speedtest.net client:
{ lib, config, pkgs, ... }: {
  options = {
    terminal.utils.speedtest-rs = {
      enable = lib.mkEnableOption "Enable Speedtest-rs.";
    };
  };
  config = lib.mkIf config.terminal.utils.speedtest-rs.enable {
    environment.systemPackages = [
      pkgs.speedtest-rs
    ];
  };
}

