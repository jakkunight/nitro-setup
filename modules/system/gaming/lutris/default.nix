{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.system.gaming;
in {
  options = {
    modules.system.gaming = {
      lutris.enable = lib.enableOption "Enable Lutris!";
    };
  };
  config = lib.mkIf cfg.lutris.enable {
    environment.systemPackages = [
      pkgs.lutris
    ];
  };
}
