let
  feature = "wireguard-server";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos =
    { config, lib, ... }:
    {
      imports = [
        den.aspects.wireguard-secrets.nixos
      ];

      sops.secrets.germain_wireguard_private_key = {
        sopsFile = ../../secrets/wireguard-germain.yaml;
        key = "private_key";
        mode = "0400";
      };

      networking.wireguard.interfaces.wg0 = {
        ips = [ "10.44.0.1/24" ];
        listenPort = 51820;
        privateKeyFile = config.sops.secrets.germain_wireguard_private_key.path;

        peers = [
          {
            publicKey = "UYaMNULHvAwCcyBQTwGEr0PyLnnw+1uMMx0obbfQU0M=";
            allowedIPs = [ "10.44.0.2/32" ];
          }
        ];
      };

      networking.firewall.allowedUDPPorts = [ 51820 ];
      boot.kernel.sysctl."net.ipv4.ip_forward" = lib.mkDefault 1;
    };
}
