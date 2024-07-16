# Network interfaces setup:
{ ... }:
{
  # Setup the network interfaces, such Wireless, Ethernet, etc:
  interfaces = {
    # Wireless interface:
    wlp62s0 = {
      useDHCP = true;
    };
  };
}
