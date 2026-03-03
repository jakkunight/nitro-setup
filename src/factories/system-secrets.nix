{ inputs, ... }:
{
  flake.factory.mkSystemSecrets =
    {
      owner ? throw "You must provide a secrets owner",
      defaultSopsFormat ? "yaml",
      keyFile ? "/home/${owner}/.config/sops/age/keys.txt",
      defaultSopsFile ? throw "You must provide a 'secrets' file matching your defined format",
      secrets ? [ ],
    }:
    {
      nixos.sops-nix =
        {
          pkgs,
          config,
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
            age = { inherit keyFile; };
            secrets = builtins.listToAttrs (
              map (x: {
                name = "${x}";
                value = {
                  owner = config.users.users.${owner}.name;
                };
              }) secrets
            );
          };
        };
    };
}
