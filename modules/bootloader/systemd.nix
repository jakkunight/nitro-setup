{ lib, config, ... }: {
  options = {
    bootloader.systemd = {
      enable = lib.mkEnableOption "Enable Systemd-Boot as your bootloader.";
      xbootldr = {
        enable = lib.mkEnableOption "Use an extended boot partition.";
      };
    };
  };
  config = lib.mkIf config.bootloader.systemd.enable {
    boot.loader = {
      efi = {
        canTouchEfiVariables = true;
      } // (
        if config.bootloader.systemd.xbootldr.enable && config.disk.filesystems.boot.xefi.enable
        then {
          efiSysMountPoint = "/efi";
        }
        else {}
      );
      systemd-boot = {
        enable = true;
      } // (
        if config.bootloader.systemd.xbootldr.enable && config.disk.filesystems.boot.xefi.enable
        then {
          xbootldrMountPoint = "/boot";
        }
        else {}
      );
    };
  };
}
