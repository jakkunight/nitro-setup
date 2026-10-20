let
  feature = "xanmod-kernel";
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
      boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
      # Enable SysRq:
      boot.kernel.sysctl."kernel.sysrq" = 1;
    };

}
