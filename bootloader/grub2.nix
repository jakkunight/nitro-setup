# A file to mannage my GRUB2 configuration.
# [Coming Soon] A GRUB theme.
{ config, lib, pkgs, inputs, ... }:
{
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        efiInstallAsRemovable = true;
      };
    };
  };
}
