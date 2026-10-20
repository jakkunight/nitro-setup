let
  feature = "boot-tuning";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos =
    { lib, ... }:
    {
      hardware.bluetooth.powerOnBoot = lib.mkForce false;
      systemd.services = {
        systemd-udev-settle.enable = false;
        NetworkManager-wait-online.enable = false;
      };
    };
}
