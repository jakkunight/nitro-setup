# A file to mannage my GRUB2 configuration.
# [Coming Soon] A GRUB theme.
{ config, lib, pkgs, inputs, ... }:
{
  time.hardwareClockInLocalTime = true;
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        efiInstallAsRemovable = true;
        theme = inputs.nixos-grub-themes.packages.${pkgs.system}.hyperfluent;
        useOSProber = true;
      };
    };
  };
}
