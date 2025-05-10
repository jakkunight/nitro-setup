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
      heroic.enable = lib.enableOption "Enable Heroic!";
    };
  };
  config = lib.mkIf cfg.heroic.enable {
    environment.systemPackages = [
      pkgs.heroic
    ];
  };
}
