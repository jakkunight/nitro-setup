# Here goes my StrongSwan IPSEC VPN connection:
{ config, lib, pkgs, ... }@inputs: {

  # Start the service:
  services.strongswan = {
    enable = true;
    secrets = [ "/etc/ipsec/.secrets" ];
    connections = {
      ANDESCADA = {
        keyexchange = "ikev1";
        ike = "aes128-sha256-modp1536!";
        esp = "aes128-sha256-modp1536!";
        agressive = "yes";
        right = "190.52.176.139";
        rightauth = "psk";
        left = "%any";
        leftsourceip = "%config";
        leftauth = "psk";
        leftauth = "xauth";
        xauth_identity = "santiago_wu";
        auto = "add";
        leftupdown = "/etc/ipsec/updown.sh"
      };
    };
  };
}
