# Here goes the networking configuration:
{ config, lib, pkgs, ... }@inputs: {
.
  # Set your time zone.
  time.timeZone = "America/Asuncion";

  # Network configuration:
  networking = {
    # IMPORTANT: Make sure this matches your host config on the flake.nix file.
    hostName = "nitro";
    # Uses NetworkManager, as this is easier to use
    networkmanager = {
      enable = true;
    };
    # Declare network interfaces, such as wireless and Ethernet ones:
    interfaces = {
      # Wireless interface:
      wlp62s0 = {
        useDHCP = true;
      };
    };
    # Put some domains that you want to be
    # "always" resolved.
    hosts = {
      "142.251.133.4" = [
        "www.google.com"
        "google.com"
      ];
      "185.178.208.140" = [
        "m.animeflv.net"
        "animeflv.net"
      ];
      "142.251.134.14" = [
        "youtube.com"
        "m.youtube.com"
        "www.youtube.com"
      ];
    };
    firewall = {
      enable = true;
      interfaces = {
        wlp62s0 = {
          # Make sure to close unnecesary ports.
          # Only enable the ports you are sure that will be used.
          allowedTCPPorts = [
            20 # File Transfer Protocol (FTP) data
            21 # FTP
            22 # Secure Shell (SSH) Protocol
            23 # TELNET Protocol (mail)
            25 # Simple Mail Transfer Protocol (SMTP)
            53 # Domain Name Server (DNS)
            80 # HyperText Transfer Protocol (HTTP)
            110 # Post Office Protocol v3 (POP3)
            123 # Network Time Protocol (NTP)
            139 # NETBIOS Session Service (NETBIOS-SSN)
            143 # Interim Mail Access Protocol v2 (IMAP2)
            161 # Simple Network Management Potocol (SNMP)
            162 # Simple Network Management Potocol (SNMP)
            389 # Lightweight Directory Access Protocol (LDAP)
            443 # HTTP over TLS/SSL (HTTPS)
            993 # Cisco Simple Network Management Potocol (SNMP)
            995 # POP-3 over SSL (POP3S)
          ];
          allowedUDPPorts = [
            20 # File Transfer Protocol (FTP) data
            21 # FTP
            22 # Secure Shell (SSH) Protocol
            23 # TELNET Protocol (mail)
            25 # Simple Mail Transfer Protocol (SMTP)
            53 # Domain Name Server (DNS)
            80 # HyperText Transfer Protocol (HTTP)
            110 # Post Office Protocol v3 (POP3)
            123 # Network Time Protocol (NTP)
            139 # NETBIOS Session Service (NETBIOS-SSN)
            143 # Interim Mail Access Protocol v2 (IMAP2)
            161 # Simple Network Management Potocol (SNMP)
            162 # Simple Network Management Potocol (SNMP)
            389 # Lightweight Directory Access Protocol (LDAP)
            443 # HTTP over TLS/SSL (HTTPS)
            993 # Cisco Simple Network Management Potocol (SNMP)
            995 # POP-3 over SSL (POP3S)
          ];
        };
      };
    };
  };

  # Other configs:
  imports = [
    ./strongswan.nix
  ];
}
