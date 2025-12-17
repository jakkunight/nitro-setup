{
  config,
  lib,
  ...
}: {
  flake.modules.nixos."hardware/cpu/intel" = {modulesPath, ...}: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    hardware.cpu.intel = {
      updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
    boot.kernelModules = ["kvm-intel"];
  };
}
