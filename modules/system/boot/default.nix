{
  config,
  lib,
  ...
}: let
  cfg = config.modules.system.boot;

  # Available configurations in the selected bootloader
  configurations =
    builtins.attrNames (builtins.readDir ../../../configurations/system/boot);
  selectedConfig = ../../../configurations/system/boot/${cfg.configuration};
in {
  options.modules.system.boot = {
    enable = lib.mkEnableOption "Enable bootloader module";
    configuration = lib.mkOption {
      type = lib.types.enum configurations;
      default = "systemd";
      description = "Which configuration to load for the selected bootloader.";
    };
  };

  config = {
    imports = [
      selectedConfig
    ];
  };
}
