let
  feature = "latest-kernel";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        # Use a custom kernel:
        boot.kernel.enable = true;
        # Allow unfree drivers:
        nixpkgs.config.allowUnfree = true;
        boot.kernelPackages = pkgs.linuxPackages_latest;
        # Enable SysRq:
        boot.kernel.sysctl."kernel.sysrq" = 1;
      };
  };
}
