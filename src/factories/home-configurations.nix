{
  inputs,
  self,
  ...
}:
{
  flake.factory.mkHomeConfiguration =
    {
      user ? throw "You must provide a homeConfiguration user",
      system ? "x86_64-linux",
    }:
    (inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs { inherit system; };
      modules = [
        self.modules.homeManager.${user}
        {
          home = {
            username = "${user}";
            homeDirectory = "/home/${user}";
            stateVersion = "26.05";
          };
        }
      ];
    });
}
