{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption types mkEnableOption;
  cfg = config.options.modules.system.nvidia;
  configPath = ../../../configs/system/nvidia;
in {
  imports = [];
  options.modules.system.nvidia = {
    enable = mkEnableOption "Weather to enable the Nvidia GPU module.";
  };
  config =
    mkIf cfg.enable {
    };
}
