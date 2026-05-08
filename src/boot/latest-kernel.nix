let
  feature = "latest-kernel";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, lib, ... }:
      {
        # Use a custom kernel:
        boot.kernel.enable = true;
        # Allow unfree drivers:
        nixpkgs.config.allowUnfree = true;
        boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
        # Enable SysRq:
        boot.kernel.sysctl."kernel.sysrq" = 1;
      };
  };
}
