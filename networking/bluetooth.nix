# Bluetooth config (even if it does not work):
{ ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  # Enable Blueman:
  services.blueman.enable = true;
}
