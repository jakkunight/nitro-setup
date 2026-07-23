let
  feature = "disk";
in
{
  flake.modules = {
    nixos.${feature} =
      {
        modulesPath,
        lib,
        ...
      }:
      {
        imports = [
          (modulesPath + "/installer/scan/not-detected.nix")
        ];

        boot.supportedFilesystems = lib.mkForce [
          "btrfs"
          "reiserfs"
          "vfat"
          "ntfs"
          "cifs"
        ];
        services.gvfs.enable = true;

        boot.initrd.availableKernelModules = [
          "xhci_pci"
          "thunderbolt"
          "vmd"
          "nvme"
          "usb_storage"
          "sd_mod"
          "ext4"
          "ext3"
        ];
      };
  };
}
