{
  config,
  lib,
  pkgs,
  ...
}: {
  # Install required dependencies:
  environment.systemPackages = with pkgs; [
    strongswan
    strongswanNM
    networkmanager_strongswan
  ];

  # Enable package forwarding:
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
  };

  # Enable the NM plugin:
  networking.networkmanager.enableStrongSwan = true;
  networking.resolvconf.enable = true;
  # Create the secrets file:
  sops.templates."andescada.secrets" = {
    content = ''
      ${config.sops.placeholder."andescada/gateway_address"} : PSK "${config.sops.placeholder."andescada/psk"}"
      ${config.sops.placeholder."andescada/username"} : XAUTH "${config.sops.placeholder."andescada/password"}"
    '';
    owner = "jakku";
  };
  environment.etc = {
    "ipsec.d/andescada/updown.sh".text = ''
      DEFAULT_GATEWAY=$(${pkgs.iproute2}/bin/ip route show | grep -i 'default via'| ${pkgs.gawk}/bin/awk '{print $3 }')
      DEV_IFACE=$(${pkgs.iproute2}/bin/ip addr show | ${pkgs.gawk}/bin/awk '/inet.*brd/{print $NF; exit}')
      VPN_SUBNET_1=$(cat ${config.sops.secrets."andescada/vpn_subnet_1".path})
      VPN_SUBNET_2=$(cat ${config.sops.secrets."andescada/vpn_subnet_2".path})
      DEFAULT_TABLE="220"

      case "$PLUTO_VERB in
          up-client)
            # sudo ip route flush table $DEFAULT_TABLE
            sudo ${pkgs.iproute2}/bin/ip route add $VPN_SUBNET_1 via $DEFAULT_GATEWAY src $PLUTO_MY_SOURCE_IP dev $DEV_IFACE proto static table $DEFAULT_TABLE
            sudo ${pkgs.iproute2}/bin/ip route add $VPN_SUBNET_2 via $DEFAULT_GATEWAY src $PLUTO_MY_SOURCE_IP dev $DEV_IFACE proto static table $DEFAULT_TABLE
            sudo ${pkgs.iproute2}/bin/ip route del default table $DEFAULT_TABLE
            sudo ${pkgs.iproute2}/bin/ip route add 10.0.0.0/8 via $DEFAULT_GATEWAY dev $DEV_IFACE src $PLUTO_ME proto dhcp table $DEFAULT_TABLE
            sudo rm /etc/resolv.conf
            sudo echo "nameserver $DEFAULT_GATEWAY" > /etc/resolv.conf
            sudo systemctl restart NetworkManager
            ;;
          down-client)
            sudo ${pkgs.iproute2}/bin/ip route del $VPN_SUBNET_1 table $DEFAULT_TABLE
            sudo ${pkgs.iproute2}/bin/ip route del $VPN_SUBNET_2 table $DEFAULT_TABLE
            sudo ${pkgs.iproute2}/bin/ip route del 0.0.0.0/0 table $DEFAULT_TABLE
            sudo ${pkgs.iproute2}/bin/ip route flush table $DEFAULT_TABLE
            ;;
      esac
    '';
  };

  # Open the firewall ports:
  networking.firewall.allowedUDPPorts = [500 4500];

  # Setup StrongSwan:
  services.strongswan = {
    enable = true;
    secrets = [
      "/run/secrets/rendered/andescada.secrets"
    ];
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
        leftupdown = "/etc/ipsec.d/andescada/updown.sh";
      };
    };
  };
}
