# Utilities to get system information:
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pciutils
    usbutils
    sysstat
    lm_sensors
    ethtool
    glxinfo
  ];
}
