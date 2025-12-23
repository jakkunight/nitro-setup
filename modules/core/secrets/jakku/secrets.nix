{inputs, ...}: {
  flake.modules.nixos."secrets/jakku" = {
    pkgs,
    config,
    lib,
    ...
  }: {
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
            aggressive = yes
            rekey_time = 28800
            over_time = 600
            local_addrs = %any
            remote_addrs = ${config.sops.placeholder."andescada/gateway_address"}

            local {
              auth = psk
              id = andescada-client
            }
            local-xauth {
              auth = xauth
              id = andescada-client
            }

            remote {
              auth = psk
              id = %any
            }

            children {
              vpn-tunnel {
                local_ts = ${config.sops.placeholder."andescada/vpn_subnet_1"}, ${config.sops.placeholder."andescada/vpn_subnet_2"}
                remote_ts = ${config.sops.placeholder."andescada/vpn_subnet_1"}, ${config.sops.placeholder."andescada/vpn_subnet_2"}


                esp_proposals = aes128-sha256-modp1536
                start_action = start
                mode = tunnel

                dpd_action = restart
                close_action = restart
              }
            }
            proposals = aes128-sha256-modp1536
            encap = yes
            # local_port = 500
            # remote_port = 500
          }
        }
        secrets {
          ike-andescada {
            id = andescada-client
            secret = "${config.sops.placeholder."andescada/psk"}"
          }
          xauth-andescada {
              id = ${config.sops.placeholder."andescada/username"}
              secret = "${config.sops.placeholder."andescada/password"}"
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
