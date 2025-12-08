{
  config,
  lib,
  ...
}: let
  inherit (lib) types mkOption mkEnableOption mkIf;
in {
  options = {
    cpuVendor = let
      inherit (types) nullOr enum;
      cpuType = nullOr (enum [
        "intel"
        "amd"
      ]);
    in
      mkOption {
        type = cpuType;
        default = null;
      };
    gpuConfig = let
      inherit (types) nullOr submodule;
      nvidiaConfigType = submodule {
        options = {};
        config = {};
      };
      noveauConfigType = submodule {
        options = {};
      };
      amdgpuConfigType = submodule {
        options = {};
      };
      gpuConfigType = submodule {
        options = {
          nvidiaConfig = mkOption {
            type = nullOr nvidiaConfigType;
            default = null;
          };
          amdgpuConfig = mkOption {
            type = nullOr amdgpuConfigType;
            default = null;
          };
          noveauConfig = mkOption {
            type = nullOr noveauConfigType;
            default = null;
          };
        };
      };
    in
      mkOption {
        type = nullOr gpuConfigType;
        default = null;
      };
  };

  config = {
    flake.modules.nixos = {
      "hardware/cpu" = {
        nixpkgs.hostPlatform =
          if config.cpuVendor == null
          then lib.mkDefault "x86_64-linux"
          else lib.mkForce "x86_64-linux";
        hardware.cpu.intel.updateMicrocode = config.cpuVendor == "intel";
        hardware.cpu.amd.updateMicrocode = config.cpuVendor == "amd";
        boot.kernelModules =
          if config.cpuVendor == "intel"
          then ["kvm-intel"]
          else if config.cpuVendor == "amd"
          then ["kvm-amd"]
          else [];
      };
      "hardware/disk" = {
        boot.initrd.availableKernelModules = [
          "xhci_pci"
          "thunderbolt"
          "vmd"
          "nvme"
        ];
      };
      "hardware/networking" = {
        networking.useDHCP = lib.mkDefault true;
      };
      "hardware/missing" = {modulesPath, ...}: {
        imports = [
          (modulesPath + "/installer/scan/not-detected.nix")
        ];
      };
      "hardware/gpu" = {
      };
    };
  };
}
