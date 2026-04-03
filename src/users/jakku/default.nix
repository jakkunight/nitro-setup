let
  user = "jakku";
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
      uid = 1000;
      isAdmin = true;
      hasNetworkAccess = true;
    })
    (self.factory.mkHomeManagerNixosModuleConfiguration { name = user; })
    (self.factory.mkSystemSecrets {
      owner = user;
      defaultSopsFile = ./secrets.yaml;
      secrets = [
        "andescada/vpn_subnet_1"
        "andescada/vpn_subnet_2"
        "andescada/gateway_address"
        "andescada/psk"
        "andescada/username"
        "andescada/password"
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
            jakku-home
            andescada
            asciinema
            obs-studio-nvidia
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

          nix.settings = {
            trusted-users = [ "${user}" ];
          };

        };
      homeManager.${user} = {
        imports = with self.modules.homeManager; [
          devenv
          core
          kanagawa-theme
          gaming
          nightmare-desktop
          swaync
          kde
          libreoffice
          nightmare-helix
          brave
          asciinema
          kdenlive
          krita
          gimp
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
