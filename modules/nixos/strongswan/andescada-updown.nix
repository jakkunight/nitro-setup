{
  config,
  pkgs,
  ...
}: let
  secretsPath = config.sops.secrets;
  ip = "${pkgs.iproute2}/bin/ip";
  awk = "${pkgs.gawk}/bin/awk";
  default_table = "220";
in
  pkgs.writeShellScriptBin "andescada-updown.sh" ''
    echo "[UPDOWN] Initilizing script..."
    DEFAULT_GATEWAY=$(${ip} route show | grep -i 'default via'| ${awk} '{print $3 }')
    DEV_IFACE=$(${ip} addr show | ${awk} '/inet.*brd/{print $NF; exit}')
    VPN_SUBNET_1=$(cat '${secretsPath."andescada/vpn_subnet_1".path}')
    VPN_SUBNET_2=$(cat '${secretsPath."andescada/vpn_subnet_2".path}')

    case "$PLUTO_VERB" in
      up-client)
        echo "[UPDOWN] Cleaning up route tables..."
        # sudo ip route flush table ${default_table}
        echo "[UPDOWN] Configuring split-tunnelling..."
        sudo ${ip} route add $VPN_SUBNET_1 via $DEFAULT_GATEWAY src $PLUTO_MY_SOURCE_IP dev $DEV_IFACE proto static table ${default_table}
        sudo ${ip} route add $VPN_SUBNET_2 via $DEFAULT_GATEWAY src $PLUTO_MY_SOURCE_IP dev $DEV_IFACE proto static table ${default_table}
        sudo ${ip} route del default table ${default_table}
        sudo ${ip} route add 10.0.0.0/8 via $DEFAULT_GATEWAY dev $DEV_IFACE src $PLUTO_ME proto dhcp table ${default_table}
        echo "[UPDOWN] Replacing default DNS resolver..."
        sudo rm /etc/resolv.conf
        sudo echo "nameserver $DEFAULT_GATEWAY" > /etc/resolv.conf
        echo "[UPDOWN] Restarting NetworkManager..."
        sudo systemctl restart NetworkManager
        echo "[UPDOWN] Success!"
        ;;
      down-client)
        echo "[UPDOWN] Erasing extra routing tables..."
        sudo ${ip} route del $VPN_SUBNET_1 table ${default_table}
        sudo ${ip} route del $VPN_SUBNET_2 table ${default_table}
        sudo ${ip} route del 0.0.0.0/0 table ${default_table}
        sudo ${ip} route flush table ${default_table}
        echo "[UPDOWN] Success!"
        ;;
    esac
    echo "[UPDOWN] The leftupdown command was successfully executed."
  ''
