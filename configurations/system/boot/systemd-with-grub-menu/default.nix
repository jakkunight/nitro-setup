{
  config,
  lib,
  ...
}: let
  device = config.modules.system.hardware.boot.bootDevice;
  theme = config.modules.system.hardware.boot.grubTheme;
in {
  # Systemd-boot is the real bootloader
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.editor = false;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    inherit device;
    # GRUB is used only as a graphical menu, not as the real bootloader
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev"; # <- don't install GRUB to a real device
      useOSProber = false;
      # Optional theme
      theme = lib.mkIf (theme != null) theme;
    };
  };
}
