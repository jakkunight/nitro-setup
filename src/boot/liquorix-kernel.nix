let
  feature = "liquorix-kernel";
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
        boot.kernelPackages = pkgs.linuxPackages_lqx;
        # Enable SysRq:
        boot.kernel.sysctl."kernel.sysrq" = 1;
      };
  };
}
