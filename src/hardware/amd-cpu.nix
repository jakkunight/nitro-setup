let
  feature = "amd-cpu";
in
{
  flake.modules = {
    nixos.${feature} =
      {
        modulesPath,
        lib,
        ...
      }:
      {
        imports = [
          (modulesPath + "/installer/scan/not-detected.nix")
        ];
        hardware = {
          cpu.amd.updateMicrocode = lib.mkDefault true;
          enableRedistributableFirmware = true;
          enableAllHardware = true;
          enableAllFirmware = true;
        };
        boot.kernelModules = [
          "kvm-amd"
        ];
      };
  };
}
