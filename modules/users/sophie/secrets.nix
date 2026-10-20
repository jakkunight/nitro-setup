let
  user = "sophie";
in
{ inputs, den, ... }:
{
  den.aspects."${user}-system-secrets".nixos =
    { pkgs, ... }:
    {
      imports = [
        inputs.sops-nix.nixosModules.sops
      ];

      environment.systemPackages = with pkgs; [
        sops
        ssh-to-age
      ];

      sops = {
        defaultSopsFile = ./secrets.yaml;
        defaultSopsFormat = "yaml";
        age = {
          keyFile = "/home/${user}/.config/sops/age/keys.txt";
          generateKey = false;
        };
        secrets = builtins.listToAttrs (
          map (x: {
            name = x;
            value = {
              owner = user;
            };
          }) [ "sophie" ]
        );
      };
    };
}
