# Networking configuration:
{ lib, config, pkgs, ... }: {
  imports = [
    ./bluetooth.nix
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

<<<<<<< HEAD
    # Disable WPA_Supplicant explicitly:
    networking.wireless.enable = lib.mkForce false;
    # Install IPRoute2:
=======
    # Disable Wireless:
    networking.wireless.enable = lib.mkForce false;
>>>>>>> rebuild

    environment.systemPackages = [
      pkgs.iproute2
    ];

    # Modules:
    net = {
      bluetooth.enable = lib.mkDefault true;
      strongswan.enable = lib.mkDefault false;
      tools.enable = lib.mkDefault true;
    };
  };
}
