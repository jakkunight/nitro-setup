_: let
  moduleName = "applications/kitty";
in {
  flake.modules = {
    homeManager.${moduleName} = {pkgs, ...}: {
      programs.kitty = {
        enable = true;
        package = pkgs.kitty;
      };
    };
  };
}
