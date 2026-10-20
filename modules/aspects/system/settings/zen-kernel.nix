let
  feature = "zen-kernel";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos =
    { pkgs, ... }:
    {
      # Use a custom kernel:
      boot.kernel.enable = true;
      # Allow unfree drivers:
      nixpkgs.config.allowUnfree = true;
      # Use latest kernel (ZEN).
      boot.kernelPackages = pkgs.linuxPackages_zen;
      # Enable SysRq:
      boot.kernel.sysctl."kernel.sysrq" = 1;
    };

}
