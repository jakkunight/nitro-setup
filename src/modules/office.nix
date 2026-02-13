let
moduleName = "office";
in _: {
    flake.homeModules.${moduleName} = {pkgs, ...}: {
      home.packages = with pkgs; [
        libreoffice
        presenterm # A MUST
        nemo
      ];
      services.remmina = {
        enable = true;
        systemdService.enable = false;
      };
    };
  }
