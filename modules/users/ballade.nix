let
  user = "ballade";
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
              obs-studio
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
          ];
          uid = 1001;
          initialPassword = user;
        };

        home-manager = {
          useGlobalPkgs = false;
          useUserPackages = false;
          backupFileExtension = "backup";
        };

        environment.sessionVariables = {
          EDITOR = "hx";
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
              core
              kanagawa-theme
              gaming
              nightmare-desktop
              swaync
              libreoffice
              nightmare-helix
              krita
              kdenlive
            ];
        home = {
          stateVersion = "26.05";
          uid = 1001;
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
        defaultSopsFile = ./ballade/secrets.yaml;
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
          }) [ "ballade" ]
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
