let
  feature = "wireguard-client";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos =
    { config, ... }:
    {
      imports = [
        den.aspects.wireguard-secrets.nixos
      ];

      sops.secrets.nitro_wireguard_private_key = {
        sopsFile = ../../secrets/wireguard-nitro.yaml;
        key = "private_key";
        mode = "0400";
      };

      networking.wireguard.interfaces.wg0 = {
        ips = [ "10.44.0.2/24" ];
        privateKeyFile = config.sops.secrets.nitro_wireguard_private_key.path;

        peers = [
          {
            publicKey = "c+TBBBS/kpHFLQanht345RjuHBHGMMAwzNj7wTq+tnI=";
            endpoint = "germain.example.com:51820";
            allowedIPs = [ "10.44.0.0/24" ];
            persistentKeepalive = 25;
          }
        ];
      };
    };
}
