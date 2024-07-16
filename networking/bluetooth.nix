# Bluetooth config (even if it does not work):
{ config, lib, pkgs, inputs, ... }:
{
  hardware.bluetooth = {
    enable = false;
    powerOnBoot = false;
  };
  # Enable Blueman:
  #services.blueman.enable = false;
}
