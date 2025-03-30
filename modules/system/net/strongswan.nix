{ lib, config, pkgs, ... }: {
  options = {
    net.strongswan = {
      enable = lib.mkEnableOption "Enable the StrongSwan support for IPSec connections.";
    };
  };
  config = lib.mkIf config.net.strongswan.enable {
    # Install all the needed packages:
    environment.systemPackages = with pkgs; [
      strongswan
      strongswanNM
      networkmanager_strongswan
    ];

    # Enable package forwarding:
    boot.kernel.sysctl."net.ipv4.ip_forward" = lib.mkForce 1;

    # Open UDP Ports on the firewall:
    networking.firewall.allowedUDPPorts = [
      500
      4500
    ];

    # Enable resolvconf:
    networking.resolvconf.enable = true;

    # NM Plugin:
    networking.networkmanager.enableStrongSwan = true;
  };
}
