let
  feature = "home-manager-nixos-module";
in
{ inputs, self, ... }:
{
  flake.factory.mkHomeManagerNixosModuleConfiguration =
    {
      name ? throw "Please provide a valid username",
    }:
    {
      nixos.${feature} = {
        imports = [
          inputs.home-manager.nixosModules.home-manager
        ];

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = false;
          users.${name} = self.modules.homeManager.${name};
        };
      };
    };
}
