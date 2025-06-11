{
  config,
  lib,
  devices,
  ...
}: let
  inherit (lib) types mkOption;
  configPath = ../../../configs/system/disko;
  layouts = builtins.readDir configPath;
  selectedConfig = configPath + "/${config.modules.system.disko.layout}";
in {
  options.modules.system.disko = {
    layout = mkOption {
      description = "The disk layout to use.";
      type = types.enum (builtins.attrNames layouts);
      default = "simple-efi";
    };
  };
  config = {
    # To avoid the bug for Disko not setting the boot device:
    boot.loader.grub.devices = [
      "nodev"
    ];
    disko.devices = import selectedConfig {inherit config lib devices;};
  };
}
