let
  user = "sophie";
in
{
  self,
  lib,
  ...
}:
{
  flake.modules = lib.mkMerge [
    (self.lib.factory.mkUser {
      name = user;
      uid = 1002;
      isAdmin = true;
      hasNetworkAccess = true;
    })
    (self.lib.factory.mkHomeManagerNixosModuleConfiguration { name = user; })
    (self.lib.factory.mkSystemSecrets {
      owner = user;
      defaultSopsFile = ./secrets.yaml;
      secrets = [
        "sophie"
      ];
    })
    {
      nixos.${user} =
        { pkgs, ... }:
        {
          imports = with self.modules.nixos; [
            core
            gaming
            libvirt
            sophie-home
          ];
          users.users.${user} = {
            useDefaultShell = false;
            shell = pkgs.zsh;
            extraGroups = [
              "libvirtd"
            ];
          };

          environment.sessionVariables = {
            EDITOR = "hx";
          };

        };
      homeManager.${user} = {
        imports = with self.modules.homeManager; [
          core
          pandora-theme
          gaming
          nightmare-desktop
          swaync
          libreoffice
          nightmare-helix
          krita
        ];
        home = {
          username = "${user}";
          homeDirectory = "/home/${user}";
          stateVersion = "26.05";
        };
      };
    }
  ];
  flake.homeConfigurations.${user} = (
    self.lib.factory.mkHomeConfiguration {
      inherit user;
      extraModules = with self.modules.homeManager; [
        stylix-standalone-hm
      ];
    }
  );
}
