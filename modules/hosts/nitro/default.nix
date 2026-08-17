let
  feature = "nitro";
in
{
  self,
  lib,
  inputs,
  ...
}:
{
  flake.modules = lib.mkMerge [
    (self.lib.factory.mkNvidiaPrimeConfig {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "";
    })
    (self.lib.diskoLayoutFactory.mkSimpleNoSwap {
      device = "/dev/nvme0n1";
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
            # zen-kernel
            latest-kernel
            zram
            # Disabled due to errors
            # inputs.determinate.nixosModules.default
            # cyberpunk-theme
            kanagawa-theme
            # tokyonight-theme
            silent-sddm
            nightmare-desktop
            # starship-desktop
            jakku
          ];
          # Enable flakes!
          nix.settings.experimental-features = lib.mkDefault [
            "nix-command"
            "flakes"
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
            gparted-full
            helix
            yazi
            btop-cuda
          ];

          services.tlp = {
            enable = true;
            pd = {
              enable = true;
            };
          };
        };
    }
  ];
  flake.nixosConfigurations.${feature} = self.lib.factory.mkHost { name = feature; };
  flake.nixosConfigurations."${feature}-offline-installer" = self.lib.factory.mkOfflineInstaller {
    name = feature;
  };
}
