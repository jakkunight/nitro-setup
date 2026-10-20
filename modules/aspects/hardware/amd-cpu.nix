let
  feature = "amd-cpu";
in
{
  den.aspects.${feature}.nixos =
    {
      modulesPath,
      lib,
      den,
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

}
