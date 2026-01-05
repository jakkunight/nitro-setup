_: let
  moduleName = "applications/remmina";
in {
  flake.modules = {
    homeManager.${moduleName} = {
      services.remmina = {
        enable = true;
        systemdService.enable = true;
      };
    };
  };
}
