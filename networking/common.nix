# Configure Hostname and timezone. Enable networking.
{ ... }:
{
  # Set your time zone.
  time.timeZone = "America/Asuncion";
  stName = "nitro";
  # Uses NetworkManager, as this is easier to use
  networkmanager = {
    enable = true;
  };
}
