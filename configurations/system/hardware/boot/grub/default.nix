{
  config,
  lib,
  ...
}: let
  device = config.modules.system.hardware.boot.bootDevice;
  theme = config.modules.system.hardware.boot.grubTheme;
in {
  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      useOSProber = true; # Optional, for dual-boot detection
      # Optional: custom theme
      theme = lib.mkIf (theme != null) theme;
      inherit device;
    };
    efi.efiSysMountPoint = "/boot";
  };
}
