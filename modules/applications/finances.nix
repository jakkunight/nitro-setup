_: let
  moduleName = "applications/finances";
in {
  flake.modules = {
    homeManager.${moduleName} = {pkgs, ...}: {
      home.packages = with pkgs; [
        mmex
      ];
    };
  };
}
