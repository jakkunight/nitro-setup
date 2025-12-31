_: let
  moduleName = "applications/vlc";
in {
  flake.modules = {
    homeManager.${moduleName} = {pkgs, ...}: {
      home.packages = with pkgs; [
        vlc
      ];
    };
  };
}
