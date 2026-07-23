{ inputs, self, ... }:
{
  flake.factory.mkHomeManagerNixosModuleConfiguration =
    {
      name ? throw "Please provide a valid username",
    }:
    {
      nixos."${name}-home" = {
        imports = [
          inputs.home-manager.nixosModules.home-manager
        ];

        home-manager = {
          useGlobalPkgs = false;
          useUserPackages = false;
          users.${name} = self.modules.homeManager.${name};
          backupFileExtension = "backup";
        };
      };
    };
}
