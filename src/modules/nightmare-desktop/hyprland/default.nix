let
  moduleName = "nightmare-desktop";
in
  {inputs, ...}: {
    flake.nixosModules = {
      pkgs,
      config,
      ...
    }: {
    };
    flake.homeModules = {
      osConfig,
      pkgs,
      ...
    }: {};
  }
