{
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.modules.system.disk;
  # Define a name for each custom disko configuration
  layouts = builtins.readDir ../../../configurations/system/disk/default.nix;
  selectedLayout = import ../../../configurations/system/disk/${cfg.layout} {
    device-target = cfg.device;
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
  imports = [
    inputs.disko.nixosModules.disko
    selectedLayout
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
}
