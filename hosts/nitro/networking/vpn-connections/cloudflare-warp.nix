# Install the cloudflare Warp client:
{ config, lib, pkgs, ... }:
{
  services.cloudflare-warp = {
    enable = true;
    openFirewall = true;
    udpPort = 2408;
    rootDir = "/var/lib/cloudflare-warp";
  };
}
