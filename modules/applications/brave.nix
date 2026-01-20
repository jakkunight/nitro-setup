{inputs, ...}: let
  moduleName = "applications/brave";
in {
  flake.modules = {
    homeManager.${moduleName} = {pkgs, ...}: {
      home.packages = with pkgs; [
        brave
      ];
    };
  };
}
