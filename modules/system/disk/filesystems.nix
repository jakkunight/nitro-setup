# A module to setup my system based on labels, 
# rather than UUID's for better reproducibility.
{ modulesPath, lib, config, ... }: {
  options = {
    disk.filesystems = {
      device = lib.mkOption {
        description = "The path into your `/dev` folder of th device used to install NixOS.";
        type = lib.types.path;
        default = /dev/sda1;
      };
      boot = {
        label = lib.mkOption {
          description = "Label for the `/boot` partition.";
          type = lib.types.nonEmptyStr;
          default = "ESP";
        };
        xefi = {
          enable = lib.mkEnableOption "Enable an extended EFI partition for boot.";
          label = lib.mkIf config.disk.boot.xefi.enable (
            lib.mkOption {
              description = "Label for the `/efi` partition.";
              type = lib.types.nonEmptyStr;
              default = "xefi";
            }
          );
        };
      };
      root = {
        label = lib.mkOption {
          description = "Label for the `/` partition.";
          type = lib.types.nonEmptyStr;
          default = "root";
        };
      };
      swap = {
        label = lib.mkOption {
          description = "Label for the `linux-swap` partition.";
          type = lib.types.nonEmptyStr;
          default = "swap";
        };
      };
    };
  };
  config = {
    fileSystems = {
      "/boot" = {
        device = "/dev/disk/by-label/${config.disk.filesystems.boot.label}";
        fsType = "vfat";
        options = [ "fmask=0022" "dmask=0022" ];
      };
      "/" = {
      device = "/dev/disk/by-label/${config.disk.filesystems.root.label}";
      fsType = "ext4";
      };
    };
    swapDevices = [
      {
        device = "/dev/disk/by-label/${config.disk.filesystems.swap.label}";
      }
    ];
  };
}
