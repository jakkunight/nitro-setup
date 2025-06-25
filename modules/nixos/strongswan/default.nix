{
  config,
  lib,
  pkgs,
  ...
}: let
  secretsPath = config.sops.secrets;
  default_table = "220";
  updown_script = {
    content = ''
      echo "[UPDOWN] Initilizing script..."
      DEFAULT_GATEWAY=$(${pkgs.iproute2}/bin/ip route show | grep -i 'default via'| ${pkgs.gawk}/bin/awk '{print $3 }')
      DEV_IFACE=$(${pkgs.iproute2}/bin/ip addr show | ${pkgs.gawk}/bin/awk '/inet.*brd/{print $NF; exit}')
      VPN_SUBNET_1=$(cat ${secretsPath."andescada/vpn_subnet_1".path})
      VPN_SUBNET_2=$(cat ${secretsPath."andescada/vpn_subnet_2".path})

      case "$PLUTO_VERB" in
        up-client)
          echo "[UPDOWN] Cleaning up route tables..."
          # sudo ip route flush table ${default_table}
          echo "[UPDOWN] Configuring split-tunnelling..."
          ${pkgs.iproute2}/bin/ip route add $VPN_SUBNET_1 via $DEFAULT_GATEWAY src $PLUTO_MY_SOURCE_IP dev $DEV_IFACE proto static table ${default_table}
          ${pkgs.iproute2}/bin/ip route add $VPN_SUBNET_2 via $DEFAULT_GATEWAY src $PLUTO_MY_SOURCE_IP dev $DEV_IFACE proto static table ${default_table}
          ${pkgs.iproute2}/bin/ip route del default table ${default_table}
          ${pkgs.iproute2}/bin/ip route add 10.0.0.0/8 via $DEFAULT_GATEWAY dev $DEV_IFACE src $PLUTO_ME proto dhcp table ${default_table}
          echo "[UPDOWN] Replacing default DNS resolver..."
          rm /etc/resolv.conf
          echo "nameserver $DEFAULT_GATEWAY" > /etc/resolv.conf
          echo "[UPDOWN] Restarting NetworkManager..."
          systemctl restart NetworkManager
          echo "[UPDOWN] Success!"
          ;;
        down-client)
          echo "[UPDOWN] Erasing extra routing tables..."
          ${pkgs.iproute2}/bin/ip route del $VPN_SUBNET_1 table ${default_table}
          ${pkgs.iproute2}/bin/ip route del $VPN_SUBNET_2 table ${default_table}
          ${pkgs.iproute2}/bin/ip route del 0.0.0.0/0 table ${default_table}
          ${pkgs.iproute2}/bin/ip route flush table ${default_table}
          echo "[UPDOWN] Success!"
          ;;
      esac
      echo "[UPDOWN] The leftupdown command was successfully executed."
    '';
    path = "ipsec.d/updown.sh";
  };
in {
  # Install required dependencies:
  environment.systemPackages = with pkgs; [
    strongswan
    strongswanNM
    networkmanager_strongswan
  ];

  # Write the script to /etc/ipsec.d
  environment.etc = {
    "${updown_script.path}" = {
      text = updown_script.content;
      mode = "771";
    };
  };

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

  # Open the firewall ports:
  networking.firewall.allowedUDPPorts = [500 4500];

  # Setup StrongSwan:
  services.strongswan = {
    enable = true;
    secrets = [
      "${config.sops.templates."andescada.secrets".path}"
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
        leftupdown = "/etc/${updown_script.path}";
      };
    };
  };
}
