{
  config,
  lib,
  ...
}: let
  cfg = config.modules.system.disko;
  inherit (lib) types mkOption;
  configPath = ../../../configs/system/disko;
  layouts = builtins.readDir configPath;
  selectedConfig = configPath + "/${cfg.layout}";
in {
  options.modules.system.disko = {
    layout = mkOption {
      description = "The disk layout to use.";
      type = types.enum (builtins.attrNames layouts);
      default = "simple-efi";
    };
    devices = mkOption {
      description = "The targeted disks connected to the host. Make sure to pass them in the order required for the layout you choose.";
      type = types.listOf types.nonEmptyStr;
      default = ["sda"];
    };
  };
  config = {
    # To avoid the bug for Disko not setting the boot device:
    boot.loader.grub.devices = ["nodev"];
    disko.devices = import selectedConfig {
      inherit config lib;
      inherit (cfg) devices;
    };
  };
}
