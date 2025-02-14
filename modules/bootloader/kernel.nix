# Set the kernel:
{ lib, config, pkgs, ... }: {
  config = {
    # Use the selected kernel:
    boot.kernel = {
      enable = true;
    };

    # Use the latest stable kernel release:
    boot.kernelPackages = pkgs.linuxPackages_6_13;
  };
}
