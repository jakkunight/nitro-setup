{pkgs, ...}: {
  # Use a custom kernel:
  boot.kernel.enable = true;
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_6_16;
  # Firmware/BIOS updates:
  services.fwupd.enable = true;
}
