{ inputs, ... }:
{
  flake.lib.factory.mkSystemSecrets =
    {
      owner ? throw "You must provide a secrets owner",
      defaultSopsFormat ? "yaml",
      keyFile ? "/home/${owner}/.config/sops/age/keys.txt",
      defaultSopsFile ? throw "You must provide a 'secrets' file matching your defined format",
      secrets ? [ ],
    }:
    {
      nixos."${owner}-system-secrets" =
        {
          pkgs,
          ...
        }:
        {
          imports = [
            inputs.sops-nix.nixosModules.sops
          ];

          environment.systemPackages = with pkgs; [
            sops
            ssh-to-age
          ];

          sops = {
            inherit defaultSopsFile defaultSopsFormat;
            age = {
              inherit keyFile;
              generateKey = false;
            };
            secrets =
              let
                modList = map (x: {
                  name = x;
                  value = {
                    inherit owner;
                  };
                }) secrets;
                result = (builtins.listToAttrs modList);
              in
              result;
          };
        };
    };
}
