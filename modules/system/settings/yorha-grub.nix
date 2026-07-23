let
  feature = "yorha-grub";
in
{ inputs, ... }:
{
  flake.modules = {
    nixos.${feature} =
      {
        lib,
        pkgs,
        ...
      }:
      {
        hardware.bluetooth.powerOnBoot = lib.mkForce false;
        systemd.services = {
          systemd-udev-settle.enable = false;
          NetworkManager-wait-online.enable = false;
        };
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
  };
}
