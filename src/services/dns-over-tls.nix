let
  feature = "dns-over-tls";
in
{ inputs, ... }:
{
  flake.modules.nixos.${feature} =
    { lib, pkgs, ... }:
    let
      StateDirectory = "dnscrypt-proxy";
    in
    {
      # Disable dynamic DNS resolution:
      networking = {
        nameservers = lib.mkForce [
          "127.0.0.1"
          "::1"
        ];
        # If using dhcpcd:
        dhcpcd.extraConfig = lib.mkForce "nohook resolv.conf";
        # If using NetworkManager:
        networkmanager.dns = lib.mkForce "none";
      };
      services.dnscrypt-proxy = {
        enable = lib.mkDefault true;
        settings = lib.mkDefault {
          # HTTP3:
          # http3 = true;
          # http3_probe = true;

          sources.public-resolvers = {
            urls = [
              "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
              "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
            ];
            minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3"; # See https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
            cache_file = "/var/lib/${StateDirectory}/public-resolvers.md";
          };
          server_names = [
            "cloudflare-security"
            "cloudflare"

          ];
          blocked_names.blocked_names_file =
            let
              blocklist_base = builtins.readFile inputs.oisd;
              extraBlocklist = "";
              blocklist_txt = pkgs.writeText "blocklist.txt" ''
                ${extraBlocklist}
                ${blocklist_base}
              '';
            in
            blocklist_txt;
        };
      };
      systemd.services.dnscrypt-proxy.serviceConfig.StateDirectory = StateDirectory;

    };
}
