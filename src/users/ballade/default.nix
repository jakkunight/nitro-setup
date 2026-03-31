let
  user = "ballade";
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
      uid = 1001;
      isAdmin = true;
      hasNetworkAccess = true;
    })
    (self.factory.mkHomeManagerNixosModuleConfiguration { name = user; })
    (self.factory.mkSystemSecrets {
      owner = user;
      defaultSopsFile = ./secrets.yaml;
      secrets = [
        "ballade"
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
            ballade-home
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
          krita
          kdenlive
          obs-studio
        ];
        home = {
          username = "${user}";
          homeDirectory = "/home/${user}";
          stateVersion = "26.05";
        };
      };
    }
  ];
}
