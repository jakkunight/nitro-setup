{ pkgs, lib, config, ... }@inputs:
{
  imports = [
    ./common.nix
    ./hosts.nix
    ./firewall.nix
    ./interfaces.nix
    ./bluetooth.nix
    ./vpn-connections/andescada.nix
    ./vpn-connections/cloudflare-warp.nix
  ];
}
