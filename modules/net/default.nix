# Networking configuration:
{ lib, config, pkgs, ... }: {
  imports = [
    ./bluetooth.nix
    ./firewall.nix
    ./interfaces.nix
    ./strongswan.nix
    ./tools
  ];
  options = {
    net = {
      enable = lib.mkEnableOption "Enable custom networking config.";
    };
  };
  config = lib.mkIf config.net.enable {
    # Default networking config?
    networking.networkmanager.enable = lib.mkForce true;
    environment.systemPackages = [
      pkgs.iproute2
    ];
    net = {
      bluetooth.enable = lib.mkDefault true;
      firewall.enable = lib.mkDefault true;
      strongswan.enable = lib.mkDefault false;
      tools.enable = lib.mkDefault true;
    };
  };
}
