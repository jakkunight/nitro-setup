{
  pkgs,
  inputs,
  lib,
  ...
}: {
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
