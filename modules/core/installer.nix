{inputs, ...}: let
  moduleName = "installer";
in {
  flake.modules.nixos.${moduleName} = {
    modulesPath,
    lib,
    ...
  }: {
    imports = [
      inputs.nixos-generators.nixosModules.all-formats
    ];
  };
}
