# Bluetooth config (even if it does not work):
{ config, lib, pkgs, inputs, ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  # Enable Blueman:
  services.blueman.enable = true;
}
