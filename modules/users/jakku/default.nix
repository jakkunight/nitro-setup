let
  user = "jakku";
in
{
  self,
  lib,
  inputs,
  ...
}:
{
  flake.modules = lib.mkMerge [
    (self.lib.factory.mkUser {
      name = user;
      uid = 1000;
      isAdmin = true;
      hasNetworkAccess = true;
    })
    # (self.lib.factory.mkHomeManagerNixosModuleConfiguration { name = user; })
    # (self.lib.factory.mkHomeConfiguration { name = user; })
    (self.lib.factory.mkSystemSecrets {
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
            # dns-over-tls
            devenv
            hermes-agent
            searxng
            scarlett2-firmware
            nmap
            gparted
            ntfs3g
            exfat-progs
            nemo
            anydesk
            handy
            wtype
            llama-cpp
            opencode
            openspec
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

          environment.systemPackages = with pkgs; [
            pi-coding-agent
            portaudio
            typstPackages.mmdr
            typstPackages.oxdraw
            markless
          ];

          environment.sessionVariables = {
            EDITOR = "hx";
          };

          nix.settings = {
            trusted-users = [ "${user}" ];
          };
        };
      homeManager.${user} = { pkgs, ... }: {
        imports = with self.modules.homeManager; [
          devenv
          core
          # cyberpunk-theme
          kanagawa-theme
          # tokyonight-theme
          # pandora-theme
          zed
          gaming
          nightmare-desktop
          # starship-desktop
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
          obs-studio-nvidia
          opencode
          llama-cpp
          openspec
        ];
        home = {
          username = "${user}";
          homeDirectory = "/home/${user}";
          stateVersion = "26.11";
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
