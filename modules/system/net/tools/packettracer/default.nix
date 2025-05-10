{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.system.net.tools.packettracer;
in {
  options = {
    modules.system.net.tools.packettracer = {
      enable = lib.mkEnableOption "Enable Cisco Packet Tracer.";
    };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.packettracer8
    ];
  };
}
