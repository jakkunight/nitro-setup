{
  config,
  lib,
  inputs,
  ...
}: let
  # Define a name for each custom disko configuration
  layouts = builtins.readDir ../../../configurations/system/disk/default.nix;
in {
  options = {
    modules.system.disk.disko = {
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
  config = {
    imports = [
      inputs.disko.nixosModules.disko
      (import ../../../configurations/system/disk/${config.modules.system.disk.layout} {
        device-target = config.modules.system.disk.device;
      })
    ];
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
