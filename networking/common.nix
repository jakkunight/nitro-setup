# Configure Hostname and timezone. Enable networking.
{ ... }:
{
  # Set your time zone.
  time.timeZone = "America/Asuncion";
  networking.hostName = "nitro";
  # Uses NetworkManager, as this is easier to use
  networking.networkmanager = {
    enable = true;
  };
}
