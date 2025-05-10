{lib, ...}: {
  boot.kernelModules = ["kvm-amd"];
  hardware.cpu.amd.updateMicrocode = true;
  nixpkgs.hostPlatform.system = lib.mkDefault "x86_64-linux";
}
