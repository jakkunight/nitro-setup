{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
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
          device = (
            if config.bootloader.grub.device.label != "nodev"
            then "/dev/disk/by-label/${config.bootloader.grub.device.label}"
            else "nodev"
          );
          efiSupport = true;
          efiInstallAsRemovable = true;
          # theme = let
          #   colorscheme = "night";
          #   layout = "teleport";
          #   resolution = "1920x1080";
          # in inputs.grubshin-bootpact.packages.${pkgs.system}.${colorscheme}.${layout}.${resolution};
          # theme = inputs.wanderer-themes.packages.${pkgs.system}.grub-theme;
          useOSProber = true;
        };
        efi = {
          efiSysMountPoint = "/boot";
          canTouchEfiVariables = false;
        };
      };
    };
  };
}
