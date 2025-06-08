{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.system.net.tools.hblock;
in {
  options = {
    modules.system.net.tools.hblock = {
      enable = lib.mkEnableOption "Enable hBlock.";
    };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.hblock
    ];
  };
}
