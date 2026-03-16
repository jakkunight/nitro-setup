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
    (self.factory.mkUser {
      name = user;
      uid = 1002;
      isAdmin = false;
      hasNetworkAccess = true;
    })
    (self.factory.mkHomeManagerNixosModuleConfiguration { name = user; })
    (self.factory.mkSystemSecrets {
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
          kanagawa-theme
          gaming
          nightmare-desktop
          swaync
          libreoffice
          nightmare-helix
        ];
        home = {
          username = "${user}";
          homeDirectory = "/home/${user}";
          stateVersion = "26.05";
        };
      };
    }
  ];
  flake.homeConfigurations.${user} = self.factory.mkHomeConfiguration {
    inherit user;
    extraModules = [
      self.modules.homeManager.stylix-standalone-hm
    ];
  };
}
