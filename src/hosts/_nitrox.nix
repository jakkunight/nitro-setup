let
  feature = "nitrox";
in
{
  self,
  lib,
  inputs,
  ...
}:
{
  flake.modules = lib.mkMerge [
    (self.factory.mkNvidiaPrimeConfig {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "";
    })
    (self.diskoLayoutFactory.mkSimpleNoSwapLuks {
      device = "/dev/nvme1n1";
      deviceName = "${feature}";
      host = "${feature}";
    })
    {
      nixos.${feature} =
        { pkgs, ... }:
        {
          imports = with self.modules.nixos; [
            intel-cpu
            disk
            bluetooth
            networking
            nvidia-gpu
            nvidia-prime
            pipewire
            yorha-grub
            zen-kernel
            inputs.determinate.nixosModules.default
            kanagawa-theme
            jakku
          ];
          system.stateVersion = "26.05";
          programs.git.enable = true;
          environment.systemPackages = with pkgs; [
            gitui
          ];
          i18n.defaultLocale = "es_PY.UTF-8";
          time.timeZone = "America/Asuncion";
          programs.nh.enable = true;
        };
    }
  ];
  flake.nixosConfigurations.${feature} = self.factory.mkHost { name = feature; };
}
