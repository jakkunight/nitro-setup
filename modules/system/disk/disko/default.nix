{
  config,
  lib,
  inputs,
  ...
}: let
  # Define a name for each custom disko configuration
  layouts = {
    simple = ./configs/simple-layout.nix;
  };
  selectedLayout = layouts.${config.modules.system.hardware.disk.disko.layout} {
    device-target = config.modules.system.hardware.disk.disko.device;
  };
in {
  options = {
    modules.system.hardware.disk.disko = {
      layout = lib.mkOptionType {
        type = lib.types.enum (builtins.attrNames layouts);
        default = "simple";
        description = "Disk layout to use with Disko";
      };
      device = lib.mkOptionType {
        type = lib.types.nonEmptyStr;
        default = "/dev/nvme0n1";
        description = "Set the instalation drive for disko";
      };
    };
  };
  imports = lib.optionals (layouts ? ${config.modules.system.hardware.disk.disko.layout}) [
    inputs.disko.nixosModules.disko
    selectedLayout
  ];
}
