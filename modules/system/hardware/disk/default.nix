{
  config,
  lib,
  ...
}: {
  # Load the disko layout
  imports = [
    ./disko
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
