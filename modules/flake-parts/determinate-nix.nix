{inputs, ...}: {
  flake.modules.nixos.determinate-nix = {
    imports = [
      inputs.determinate.nixosModules.default
    ];
  };
}
