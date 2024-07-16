# A file to mannage my GRUB2 configuration.
# [Coming Soon] A GRUB theme.
{ ... }:
{
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nidev";
        efiSupport = true;
        efiInstallAsRemovable = true;
      };
    };
  };
}
