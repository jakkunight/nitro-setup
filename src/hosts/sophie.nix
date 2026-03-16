let
  feature = "sophie";
in
{
  self,
  lib,
  inputs,
  ...
}:
{
  flake.modules = lib.mkMerge [
    (self.diskoLayoutFactory.mkSimpleNoSwap {
      device = "/dev/sda";
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
            silent-sddm
            nightmare-desktop
            kde
            cinnamon
            ballade
            sophie
            jakku
          ];
          i18n.defaultLocale = "es_PY.UTF-8";
          time.timeZone = "America/Asuncion";
          services.xserver = {
            xkb.layout = "latam";
          };
          services.libinput.enable = true;
          # system.includeBuildDependencies = true;
          environment.systemPackages = with pkgs; [
            gitui
            inputs.home-manager.packages.${system}.home-manager
            inputs.disko.packages.${system}.disko
          ];
        };
    }
  ];
  flake.nixosConfigurations.${feature} = self.factory.mkHost { name = feature; };
  flake.nixosConfigurations."${feature}-offline-installer" = self.factory.mkOfflineInstaller {
    name = feature;
  };
}
