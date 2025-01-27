# Config for ANDESCADA connection.
# [IMPORTANT] This file contents the VPN connection
# to the ANDESCADA system. DO NOT EXPOSE ANY SENSITVE
# DATA INTO THIS FILE!!!
{ config, lib, ... }: {
  options = {
    serv.vpns.strongswan.connections.andescada = {
      enable = lib.mkEnableOption "Enable the ANDESCADA connection on this system.";
    };
  };
  config = lib.mkIf config.serv.vpns.strongswan.connections.andescada.enable {
    # Configure the service:
    services.strongswan = {
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
  };
}
