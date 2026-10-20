let
  user = "jakku";
in
{
  self,
  lib,
  inputs,
  den,
  ...
}:
{
  den.aspects.${user} = {
    nixos =
      { pkgs, ... }:
      {
        imports =
          with den.aspects;
          map
            (
              a:
              if builtins.isAttrs a && a ? nixos then
                (
                  let
                    v = a.nixos;
                  in
                  if builtins.isAttrs v && v ? __contentValues then
                    { imports = map (d: d.value) v.__contentValues; }
                  else
                    v
                )
              else if builtins.isAttrs a && a ? provides then
                { }
              else
                a
            )
            [
              core
              gaming
              libvirt
              andescada
              asciinema
              obs-studio-nvidia
              podman
              wireshark
              multimedia-production
              devenv
              hermes-agent
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

        users.groups.${user} = { };
        users.users.${user} = {
          group = user;
          isNormalUser = true;
          useDefaultShell = false;
          shell = pkgs.zsh;
          extraGroups = [
            "wheel"
            "networkmanager"
            "input"
            "libvirtd"
            "podman"
            "wireshark"
            "jackaudio"
            "audio"
          ];
          uid = 1000;
          initialPassword = user;
        };

        environment.systemPackages = with pkgs; [
          pi-coding-agent
          portaudio
          typstPackages.mmdr
          typstPackages.oxdraw
          markless
          rustscan
          netscanner
          netscan
          droidcam
          termusic
        ];

        environment.sessionVariables = {
          EDITOR = "hx";
        };

        nix.settings = {
          trusted-users = [ "${user}" ];
        };
      };

    homeManager =
      { pkgs, ... }:
      {
        imports =
          with den.aspects;
          map
            (
              a:
              if builtins.isAttrs a && a ? homeManager then
                (
                  let
                    v = a.homeManager;
                  in
                  if builtins.isAttrs v && v ? __contentValues then
                    { imports = map (d: d.value) v.__contentValues; }
                  else
                    v
                )
              else if builtins.isAttrs a && a ? provides then
                { }
              else
                a
            )
            [
              devenv
              core
              kanagawa-theme
              zed
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
              obs-studio-nvidia
              opencode
              llama-cpp
              openspec
            ];
        home = {
          stateVersion = "26.11";
          uid = 1000;
        };
      };
  };

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
        defaultSopsFile = ./jakku/secrets.yaml;
        defaultSopsFormat = "yaml";
        age = {
          keyFile = "/home/${user}/.config/sops/age/keys.txt";
          generateKey = false;
        };
        secrets = builtins.listToAttrs (
          map
            (x: {
              name = x;
              value = {
                owner = user;
              };
            })
            [
              "andescada/vpn_subnet_1"
              "andescada/vpn_subnet_2"
              "andescada/gateway_address"
              "andescada/psk"
              "andescada/username"
              "andescada/password"
            ]
        );
      };
    };

  den.homes.x86_64-linux.${user} = {
    includes = [
      den.aspects.stylix-standalone-hm
      den.aspects.standalone-home
    ];
  };
}
