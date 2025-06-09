{
  config,
  lib,
  ...
}: let
  # Available configurations in the selected bootloader
  configurations = builtins.readDir ../../../configurations/system/boot;
in {
  options.modules.system.boot = {
    enable = lib.mkEnableOption "Enable bootloader module";
    configuration = lib.mkOption {
      type = lib.types.enum (builtins.attrNames configurations);
      default = "systemd";
      description = "Which configuration to load for the selected bootloader.";
    };
    imports = [
      ../../../configurations/system/boot/${config.modules.system.boot.configuration}
    ];
  };
}
