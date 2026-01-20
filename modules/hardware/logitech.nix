_: let
  moduleName = "hardware/logitech";
in {
  flake.modules = {
    homeManager.${moduleName} = {pkgs, ...}: {
      home.packages = with pkgs; [
        solaar
      ];
    };
  };
}
