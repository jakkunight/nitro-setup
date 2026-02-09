{inputs, ...}: let
  moduleName = "installer";
in {
  flake.modules.nixos.${moduleName} = {
    modulesPath,
    lib,
    ...
  }: {
    # imports = [
    #   inputs.nixos-generators.nixosModules.all-formats
    # ];

    # Bootstrap this flake into the ISO installer:
    environment.etc.nixos.source = ../../.;
    system.copySystemConfiguration = false;
    # system.includeBuildDependencies = true;
  };
}
