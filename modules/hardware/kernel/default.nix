{
  flake.modules.nixos."hardware/kernel" = {pkgs, ...}: {
    # Use a custom kernel:
    boot.kernel.enable = true;
    # Use latest kernel.
    boot.kernelPackages = pkgs.linuxPackages_latest;
    # Enable SysRq:
    boot.kernel.sysctl."kernel.sysrq" = 1;
    # Firmware/BIOS updates:
    services.fwupd.enable = true;
  };
}
