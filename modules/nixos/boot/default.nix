{pkgs, ...}:{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup the GRUB menu:
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
