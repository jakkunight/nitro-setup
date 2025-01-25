{ lib, config, inputs, ... }: {
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
          efiInstallAsRemovable = false;
          theme = let
            layout = "classic";
            resolution = "1920x1080";
            colorscheme = "night";
          in inputs.grubshin-bootpact.${colorscheme}.${layout}.${resolution};
          useOSProber = true;
        };
        efi = {
          efiSysMountPoint = "/boot";
        };
      };
    };
  };
}
