# Here goes my StrongSwan IPSEC VPN connection:
{ config, lib, pkgs, ... }@inputs: {

  # NM Plugin:
  networking.networkmanager.enableStrongSwan = true;

  # Set env variables:
  # environment.sessionVariables = rec {
  #   STRONGSWAN_CONF = "/etc/ipsec.conf";
  # };

  # Start the service:
  services.strongswan = {
    enable = true;
    secrets = [ "/etc/ipsec/.secrets" ];
    connections = {
      andescada = {
        keyexchange = "ikev1";
        ike = "aes128-sha256-modp1536!";
        esp = "aes128-sha256-modp1536!";
        agressive = "yes";
        right = "190.52.176.139";
        rightauth = "psk";
        left = "%any4";
        leftsourceip = "%config4";
        leftauth = "psk";
        leftauth2 = "xauth";
        xauth_identity = "santiago_wu";
        auto = "add";
        leftupdown = "/etc/ipsec/updown.sh";
      };
    };
  };
}
