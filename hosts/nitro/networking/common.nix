# Configure Hostname and timezone. Enable networking.
{ config, lib, pkgs, ... }:
{
  # Set your time zone.
  time.timeZone = "America/Asuncion";
  networking.hostName = "nitro";
  # Uses NetworkManager, as this is easier to use
  networking.networkmanager = {
    enable = true;
  };
  # Disable Wireless:
  networking.wireless = {
    enable = false;
  };
}
