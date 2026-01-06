_: let
  moduleName = "applications/zenmap";
in {
  flake.modules = {
    homeManager.${moduleName} = {
      lib,
      osConfig,
      pkgs,
      ...
    }: {
      home.packages = with pkgs; [
        zenmap
        nmap
      ];
    };
  };
}
