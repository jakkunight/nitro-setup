# Configure the kernel version to use:
{ config, pkgs, lib, ... }@inputs:
{
  boot.kernel = {
    enable = true;
  };

  # Use the latest stable kernel release:
  boot.kernelPackages = pkgs.linuxPackages_6_10;
}
