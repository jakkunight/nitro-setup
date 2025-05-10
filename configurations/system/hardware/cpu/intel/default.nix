{lib, ...}: {
  boot.kernelModules = ["kvm-intel"];
  hardware.cpu.intel.updateMicrocode = true;
  nixpkgs.hostPlatform.system = lib.mkDefault "x86_64-linux";
}
