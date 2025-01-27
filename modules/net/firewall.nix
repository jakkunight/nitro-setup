# Firewall configuration. Allow known ports only to be open:
{ config, lib,  ... }: {
  options = {
    net.firewall = {
      enable = lib.mkEnableOption "Enable the default firewall.";
    };
  };

  config = {
    networking.firewall = {
      enable = true;
      interfaces = {
        # Wireless interface:
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
        # Ethernet interface:
        enp63s0 = {
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
}

