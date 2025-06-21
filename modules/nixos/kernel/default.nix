{pkgs, ...}:
{
  # Use a custom kernel:
  boot.kernel = true;
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
