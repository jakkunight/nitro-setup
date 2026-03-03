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
      uid = 1001;
      isAdmin = false;
      hasNetworkAccess = true;
    })
    {
      nixos.${user} = {
        imports = with self.modules.nixos; [
          core
        ];
      };
      homeModules.${user} = {
        imports = with self.modules.homeModules; [
          core
        ];
      };
    }
  ];
}
