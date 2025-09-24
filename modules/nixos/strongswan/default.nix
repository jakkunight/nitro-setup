{
  config,
  pkgs,
  ...
}: let
  andescada-updown = ''
    echo "[UPDOWN] Initilizing script..."
    case "$PLUTO_VERB" in
      up-client)
        echo "[INFO] Turning up IPSec Client..."
        echo "[INFO] Getting interface..."
        iface=lo.ipsec
        echo "[INFO] Removing DNS resolution via VPN DNS Server..."
        echo "nameserver 1.1.1.1" | ${pkgs.openresolv}/bin/resolvconf -a $iface
        if [ $? -ne 0 ]; then
          echo "[WARN] Could not remove DNS resolution via VPN DNS Server."
          echo "[WARN] You can still use the VPN, but some domains might be"
          echo "[WARN] unaccessable due to security policies."
        else
           echo "[SUCCESS] VPN DNS Server resolution removed!"
        fi
        echo "[SUCCESS] The IPSec Client is UP!"
        ;;
      down-client)
        echo "[INFO] Turning down IPSec Client..."
        echo "[SUCCESS] The IPSec Client is DOWN!"
        ;;
    esac
    echo "[SUCCESS] The leftupdown command was successfully executed."
  '';
in {
  # Set the secrets up:
  sops.secrets = {
    "andescada/vpn_subnet_1" = {
      owner = "jakku";
    };
    "andescada/vpn_subnet_2" = {
      owner = "jakku";
    };
    "andescada/gateway_address" = {
      owner = "jakku";
    };
    "andescada/psk" = {
      owner = "jakku";
    };
    "andescada/username" = {
      owner = "jakku";
    };
    "andescada/password" = {
      owner = "jakku";
    };
  };
  # Install required dependencies:
  environment.systemPackages = with pkgs; [
    strongswan
    strongswanNM
    networkmanager_strongswan
  ];

  environment.etc = {
    "ipsec.d/andescada/updown.sh" = {
      text = "${andescada-updown}";
      mode = "0770";
    };
  };

  # Enable package forwarding:
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
  };

  # Enable the NM plugin:
  networking.networkmanager.plugins = with pkgs; [
    networkmanager_strongswan
  ];
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
        leftupdown = "/etc/ipsec.d/andescada/updown.sh";
      };
    };
  };
}
