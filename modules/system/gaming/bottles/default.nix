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
      bottles.enable = lib.enableOption "Enable Bottles!";
    };
  };
  config = lib.mkIf cfg.bottles.enable {
    environment.systemPackages = [
      pkgs.bottles
    ];
  };
}
