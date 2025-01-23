{ lib, config, ... }: {
  options = {
    bootloader.grub = {
      enable = lib.mkEnableOption "Enable GRUB as your bootloader";
      device = {
        label = lib.mkOption {
          description = "Set the device's label where GRUB will be installed. Defaults to `nodev`";
          type = lib.types.str;
          default = "nodev";
        };
      };
    };
  };
  config = lib.mkIf config.bootloader.grub.enable {
    time.hardwareClockInLocalTime = true;
    boot = {
      loader = {
        grub = {
          enable = lib.mkForce true;
          device = "/dev/disk/by-label/${config.bootloader.grub.device.label}";
          efiSupport = true;
          efiInstallAsRemovable = true;
          #theme = inputs.nixos-grub-themes.packages.${pkgs.system}.hyperfluent;
          useOSProber = true;
        };
      };
    };
  };
}
