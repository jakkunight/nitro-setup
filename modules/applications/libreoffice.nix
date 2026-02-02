_: let
  moduleName = "applications/libreoffice";
in {
  flake.modules = {
    homeManager.${moduleName} = {pkgs, ...}: {
      home.packages = with pkgs; [
        libreoffice
        # Office alternatives
        abiword
        gnumeric
        presenterm # A MUST
      ];
    };
  };
}
