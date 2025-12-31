_: let
  moduleName = "applications/nemo";
in {
  flake.modules = {
    homeManager.${moduleName} = {pkgs, ...}: {
      home.packages = with pkgs; [
        nemo
      ];
    };
  };
}
