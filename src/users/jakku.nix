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
    {
      nixos.${user} =
        { pkgs, ... }:
        {
          imports = with self.modules.nixos; [
            core
            gaming
            libvirt
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
          devenv
          core
          kanagawa-theme
          gaming
          nightmare-desktop
          swaync
          kde
          libreoffice
        ];
      };
    }
  ];
  flake.homeConfigurations.${user} = self.factory.mkHomeConfiguration {
    inherit user;
  };
}
