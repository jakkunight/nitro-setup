let
  feature = "yorha-grub";
in
{ inputs, ... }:
{
  den.aspects.${feature}.nixos =
    {
      lib,
      pkgs,
      den,
      ...
    }:
    {
      boot.loader = {
        efi = {
          canTouchEfiVariables = true;
        };
        systemd-boot = {
          enable = false;
        };
        grub = {
          enable = true;
          efiSupport = true;
          device = "nodev";
          useOSProber = true;
          efiInstallAsRemovable = false;
          theme = lib.mkForce "${inputs.yorha-grub-theme.packages.${pkgs.stdenv.hostPlatform.system}.default
          }";
        };
      };
    };

}
