let
  feature = "intel-cpu";
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
          cpu.intel.updateMicrocode = lib.mkDefault true;
          enableRedistributableFirmware = true;
          enableAllHardware = true;
          enableAllFirmware = true;
        };
        boot.kernelModules = [
          "kvm-intel"
        ];
      };
  };
}
