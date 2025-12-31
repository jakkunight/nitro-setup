_: let
  moduleName = "applications/zed-editor";
in {
  flake.modules = {
    homeManager.${moduleName} = {pkgs, ...}: {
      home.packages = with pkgs; [
        zed-editor
      ];
    };
  };
}
