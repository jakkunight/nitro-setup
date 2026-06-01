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
    # (self.factory.mkHomeManagerNixosModuleConfiguration { name = user; })
    # (self.factory.mkHomeConfiguration { name = user; })
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
            # jakku-home
            andescada
            asciinema
            obs-studio-nvidia
            podman
            nix-auth
            wireshark
            multimedia-production
            dns-over-tls
          ];
          users.users.${user} = {
            useDefaultShell = false;
            shell = pkgs.zsh;
            extraGroups = [
              "libvirtd"
              "podman"
              "wireshark"
              "jackaudio"
              "audio"
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
          # kanagawa-theme
          tokyonight-theme
          gaming
          nightmare-desktop
          swaync
          kde
          libreoffice
          nightmare-helix
          brave
          asciinema
          audacity
          kdenlive
          krita
          gimp
          terminal-gadgets
          wanderer-fastfetch
          zed
          opencode
          ollama-cuda
        ];
        home = {
          username = "${user}";
          homeDirectory = "/home/${user}";
          stateVersion = "26.11";
        };
        programs.zed-editor = {
          userSettings = {
            helix_mode = true;
          };
        };
      };
    }
  ];
  flake.homeConfigurations.${user} = (
    self.factory.mkHomeConfiguration {
      inherit user;
      extraModules = with self.modules.homeManager; [
        stylix-standalone-hm
      ];
    }
  );
}
