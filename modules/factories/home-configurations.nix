{
  inputs,
  self,
  lib,
  ...
}:
{
  flake.lib.factory.mkHomeConfiguration =
    {
      user ? throw "You must provide a homeConfiguration user",
      system ? "x86_64-linux",
      extraModules ? [ ],
    }:
    (inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs { inherit system; };
      extraSpecialArgs = { inherit inputs; };
      modules = lib.concatLists [
        extraModules
        [
          self.modules.homeManager.${user}
          (
            { pkgs, ... }:
            {
              nix.package = pkgs.nix;
              home = {
                username = lib.mkDefault "${user}";
                homeDirectory = lib.mkDefault "/home/${user}";
                stateVersion = lib.mkDefault "26.05";
              };
            }
          )
        ]
      ];
    });
}
