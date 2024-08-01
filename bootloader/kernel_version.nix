# Configure the kernel version to use:
{ config, pkgs, lib, inputs }:
{
  # Use the latest stable kernel release:
  boot.kernelPackages = pkgs.linuxPackages_6_10;
}
