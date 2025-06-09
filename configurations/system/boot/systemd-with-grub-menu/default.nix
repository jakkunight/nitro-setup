{
  config,
  lib,
  ...
}: {
  # Systemd-boot is the real bootloader
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.editor = false;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    # GRUB is used only as a graphical menu, not as the real bootloader
    grub = {
      enable = true;
      efiSupport = true;
      useOSProber = true;
      # Optional theme
      theme = null;
    };
  };
}
