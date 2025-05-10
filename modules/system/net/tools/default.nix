{
  config,
  lib,
  ...
}: {
  imports = [
    ./hblock
    ./gns3
    ./iproute2
    ./netscanner
    ./packettracer
    ./speedtest
    ./wireless
    ./wireshark
  ];
  modules.system.net.tools = {
    hblock.enable = lib.mkDefault true;
    speedtest.enable = lib.mkDefault true;
    iproute2.enable = lib.mkDefault true;
    wireless.enable = lib.mkDefault true;
  };
}
