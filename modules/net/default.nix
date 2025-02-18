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

    # Disable WPA_Supplicant explicitly:
    networking.wireless.enable = lib.mkForce false;
    
    # Install IPRoute2:
    environment.systemPackages = [
      pkgs.iproute2
    ];

    # Modules:
    net = {
      bluetooth.enable = lib.mkDefault true;
      firewall.enable = lib.mkDefault true;
      strongswan.enable = lib.mkDefault false;
      tools.enable = lib.mkDefault true;
    };
  };
}
