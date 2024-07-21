# Install the cloudflare Warp client:
{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cloudflare-warp
  ];
}
