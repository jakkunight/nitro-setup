{
  inputs,
  config,
  lib,
  ...
}: {
  flake.nixosConfigurations.nitro = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
  };
}
