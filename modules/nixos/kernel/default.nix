{pkgs, ...}: {
  # Use a custom kernel:
  boot.kernel.enable = true;
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # Firmware/BIOS updates:
  services.fwupd.enable = true;
}
