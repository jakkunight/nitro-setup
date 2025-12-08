{
  inputs,
  config,
  ...
}: {
  cpuVendor = "intel";
  flake.nixosConfigurations.nitro = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      config.flake.modules.nixos."hosts/nitro"
      config.flake.modules.nixos."hardware/cpu"
      config.flake.modules.nixos."hardware/disk"
      config.flake.modules.nixos."hardware/networking"
      config.flake.modules.nixos."hardware/missing"
    ];
  };
}
