# Here goes my StrongSwan IPSEC VPN connection:
{ config, lib, pkgs, ... }@inputs: {

  # Enable package forwarding:
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  # Enable resolvconf:
  networking.resolvconf.enable = true;

  # NM Plugin:
  networking.networkmanager.enableStrongSwan = true;
  #services.xl2tpd.enable = true;

  # Set env variables:
  # environment.sessionVariables = rec {
  #   STRONGSWAN_CONF = "/etc/ipsec.conf";
  # };

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
        right = "190.52.176.139";
        rightid = "%any";
        rightsubnet = "10.0.0.0/8";
        rightauth = "psk";
        left = "%defaultroute";
        leftsourceip = "%config";
        leftsubnet = "10.0.0.0/8";
        leftauth = "psk";
        leftauth2 = "xauth";
        xauth_identity = "santiago_wu";
        auto = "add";
        leftupdown = "/etc/ipsec/updown.sh";
      };
    };
  };
}
