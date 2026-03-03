{ lib, ... }:
{
  flake.factory.mkUser =
    {
      name ? throw "You must provide a valid username",
      uid ? throw "You must provide a valid uid",
      isAdmin ? false,
      hasNetworkAccess ? false,
    }:
    {
      nixos.${name} = {
        users.groups.${name} = { };
        users.users.${name} = {
          group = "${name}";
          isNormalUser = true;
          extraGroups = lib.mkMerge [
            (lib.mkIf isAdmin [ "wheel" ])
            (lib.mkIf hasNetworkAccess [ "networkmanager" ])
            [ "input" ]
          ];
          inherit uid;
          initialPassword = "${name}";
        };
      };
      homeModules.${name} = {
        home = {
          username = "${name}";
          homeDirectory = "/home/${name}";
          inherit uid;
        };
      };
    };
}
