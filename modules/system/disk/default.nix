{
  config,
  lib,
  inputs,
  ...
}: let
  # Define a name for each custom disko configuration
  layouts = builtins.readDir ../../../configurations/system/disk;
in {
  options = {
    modules.system.disk = {
      layout = lib.mkOption {
        type = lib.types.enum (builtins.attrNames layouts);
        default = "simple";
        description = "Disk layout to use with Disko";
      };
      device = lib.mkOption {
        type = lib.types.nonEmptyStr;
        default = "/dev/nvme0n1";
        description = "Set the instalation drive for disko";
      };
      name = lib.mkOption {
        type = lib.types.nonEmptyStr;
        default = "nixos";
        description = "Set the instalation drive for disko";
      };
    };
  };
  imports = [
    inputs.disko.nixosModules.disko
  ];

  config = {
    # Set the device target:
    disko.devices.disk.${config.modules.system.disk.name} = {
      inherit (config.modules.system.disk) device;
      type = "disk";
      content = import ../../../configurations/system/disk/${config.modules.system.disk.layout};
    };
    # Loads ALL the drivers for mass storage devices
    boot.initrd.availableKernelModules = [
      "xhci_pci"
      "thunderbolt"
      "vmd"
      "nvme"
      "usb_storage"
      "sd_mod"
    ];
  };
}
