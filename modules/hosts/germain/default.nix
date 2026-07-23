let
  feature = "germain";
in
{
  self,
  lib,
  inputs,
  ...
}:
{
  flake.modules = lib.mkMerge [
    (self.lib.diskoLayoutFactory.mkSimpleNoSwap {
      device = "/dev/sda";
      deviceName = "main";
      host = "${feature}";
    })
    {
      nixos."${feature}" =
        { pkgs, ... }:
        {
          imports = with self.modules.nixos; [
            intel-cpu
            disk
            bluetooth
            networking
            pipewire
            yorha-grub
            # zen-kernel # Since it's vulnerable to Copy.fail exploit.
            latest-kernel
            inputs.determinate.nixosModules.default
            kanagawa-theme
            silent-sddm
            nightmare-desktop
            kde
            cinnamon
            ballade
            # sophie
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
  flake.nixosConfigurations.${feature} = self.lib.factory.mkHost { name = feature; };
  flake.nixosConfigurations."${feature}-offline-installer" = self.lib.factory.mkOfflineInstaller {
    name = feature;
  };
}
