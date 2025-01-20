# Network interfaces setup:
{ config, lib, pkgs, inputs, ... }:
{
  # Setup the network interfaces, such Wireless, Ethernet, etc:
  networking.interfaces = {
    # Wireless interface:
    wlp62s0 = {
      useDHCP = true;
    };
    # Ethernet interface:
    enp63s0 = {
      useDHCP = true;
    };
  };
}
