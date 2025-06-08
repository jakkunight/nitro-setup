{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.system.net.tools.wireshark;
in {
  options = {
    modules.system.net.tools.wireshark = {
      enable = lib.mkEnableOption "Enable Wireshark.";
    };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.wireshark
    ];
  };
}
