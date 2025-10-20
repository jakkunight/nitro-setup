{
  pkgs,
  inputs,
  lib,
  ...
}: {
  # NOTE:
  # These services are disabled, since they add A LOT of time to the
  # boot process and almos everything that has something to do with the
  # disk/networking/kernel.
  systemd.services = {
    systemd-udev-settle.enable = false;
    NetworkManager-wait-online.enable = false;
  };
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    systemd-boot = {
      enable = false;
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
      efiInstallAsRemovable = false;
      theme = lib.mkForce "${inputs.wanderer-grub-theme.packages.${pkgs.system}.grub-theme}";
    };
  };
}
