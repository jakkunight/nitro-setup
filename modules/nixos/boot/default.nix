{pkgs, ...}: {
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    systemd-boot = {
      enable = true;
    };
    grub = {
      enable = false;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
      efiInstallAsRemovable = false;
    };
  };
}
