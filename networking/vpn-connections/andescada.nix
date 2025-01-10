# [IMPORTANT] This file contents the VPN connection
# to the ANDESCADA system. DO NOT EXPOSE ANY SENSITVE
# DATA INTO THIS FILE!!!
{ config, pkgs, lib, inputs, ... }:
{
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

  # Start the service:
  services.strongswan = {
    enable = true;
    secrets = [ "/etc/ipsec/andescada.secret" ];
    connections = {
      andescada = {
        keyexchange = "ikev1";
        keyingtries = "1";
        ike = "aes128-sha256-modp1536!";
        esp = "aes128-sha256-modp1536!";
        aggressive = "yes";
        right = "190.52.176.139"; # Replace this with your VPN gateway IP address.
        rightid = "%any";
        rightsubnet = "10.0.0.0/8";
        rightauth = "psk";
        left = "%defaultroute";
        leftsourceip = "%config";
        leftsubnet = "10.0.0.0/8";
        leftauth = "psk";
        leftauth2 = "xauth";
        xauth_identity = "santiago_wu"; # Replace this with your username.
        auto = "add";
        leftupdown = "/etc/ipsec/updown.sh"; # Make sure that your custom script works.
      };
    };
  };
}
