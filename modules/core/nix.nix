{inputs, ...}: {
  flake.modules.nixos."nix" = _: {
    imports = [
      inputs.determinate.nixosModules.default
    ];
  };
}
