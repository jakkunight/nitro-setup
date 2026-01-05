{inputs, ...}: {
  flake.modules.nixos."secrets/jakku" = {
    pkgs,
    config,
    lib,
    ...
  }: let
    andescada-updown = pkgs.writeShellScriptBin "andescada-updown" ''
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
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];
    sops.defaultSopsFile = ../../../../secrets/jakku/secrets.yaml;
    sops.defaultSopsFormat = "yaml";
    sops.age = {
      keyFile = "/home/jakku/.config/sops/age/keys.txt";
      generateKey = false;
    };
    sops.secrets = {
      "andescada/vpn_subnet_1" = {
      };
      "andescada/vpn_subnet_2" = {
      };
      "andescada/gateway_address" = {
      };
      "andescada/psk" = {
      };
      "andescada/username" = {
      };
      "andescada/password" = {
      };
    };
    # 1. Enable the service:
    boot.kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
    };

    environment.systemPackages = with pkgs; [
      strongswan
      strongswanNM
      andescada-updown
    ];
    # The swanctl command complains when the following directories don't exist:
    # See: https://wiki.strongswan.org/projects/strongswan/wiki/Swanctldirectory
    systemd.tmpfiles.rules = [
      "d /etc/swanctl/x509 -" # Trusted X.509 end entity certificates
      "d /etc/swanctl/x509ca -" # Trusted X.509 Certificate Authority certificates
      "d /etc/swanctl/x509ocsp -"
      "d /etc/swanctl/x509aa -" # Trusted X.509 Attribute Authority certificates
      "d /etc/swanctl/x509ac -" # Attribute Certificates
      "d /etc/swanctl/x509crl -" # Certificate Revocation Lists
      "d /etc/swanctl/pubkey -" # Raw public keys
      "d /etc/swanctl/private -" # Private keys in any format
      "d /etc/swanctl/rsa -" # PKCS#1 encoded RSA private keys
      "d /etc/swanctl/ecdsa -" # Plain ECDSA private keys
      "d /etc/swanctl/bliss -"
      "d /etc/swanctl/pkcs8 -" # PKCS#8 encoded private keys of any type
      "d /etc/swanctl/pkcs12 -" # PKCS#12 containers
    ];

    # 2. Write the config file to `/etc/swanctl/swanctl.conf`
    sops.templates."strongswan-swanctl.conf" = {
      path = "/etc/swanctl/swanctl.conf";
      content = ''
        connections {
          andescada {
            version = 1
            keyingtries = 1
            aggressive = yes
            proposals = aes128-sha256-modp1536

            local_addrs = 0.0.0.0/0,::/0
            remote_addrs = ${config.sops.placeholder."andescada/gateway_address"}

            local-1 {
              auth = psk
              id = %any
            }

            remote-1 {
              auth = psk
              id = %any
            }

            local-2 {
              auth = xauth
              xauth_id = ${config.sops.placeholder."andescada/username"}
            }

            vips = 0.0.0.0,::

            children {
              vpn-tunnel {
                start_action = none # default
                esp_proposals = aes128-sha256-modp1536
                remote_ts = 10.0.0.0/8
                # local_ts = 192.168.1.0/24
                updown = ${(lib.getExe andescada-updown)}
              }
            }
          }
        }
        secrets {
          ike-1 {
            secret = ${config.sops.placeholder."andescada/psk"}
            id = %any
          }
          xauth-1 {
            secret = ${config.sops.placeholder."andescada/password"}
            id = ${config.sops.placeholder."andescada/username"}
          }
        }
      '';
    };
    environment.etc."swanctl/swanctl.conf".source = config.sops.templates."strongswan-swanctl.conf".path;
    environment.etc."strongswan.conf".text = '''';
    systemd.services.strongswan-swanctl = {
      description = "strongSwan IPsec IKEv1/IKEv2 daemon using swanctl";
      wantedBy = ["multi-user.target"];
      wants = ["network-online.target"];
      after = ["network-online.target"];
      path = with pkgs; [
        kmod
        iproute2
        iptables
        util-linux
      ];
      restartTriggers = [
        config.environment.etc."swanctl/swanctl.conf".source
        config.environment.etc."strongswan.conf".source
      ];
      serviceConfig = {
        ExecStart = "${pkgs.strongswan}/sbin/charon-systemd";
        Type = "notify";
        ExecStartPost = "${pkgs.strongswan}/sbin/swanctl --load-all --noprompt";
        ExecReload = "${pkgs.strongswan}/sbin/swanctl --reload";
        Restart = "on-abnormal";
      };
    };
  };
}
