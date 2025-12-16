{
  inputs,
  lib,
  config,
  ...
}: {
  flake.modules.nixos."boot/grub/wanderer-themes" = {pkgs, ...}: {
    options = {
      enable = lib.mkEnableOption {
        default = false;
      };
    };
    config = lib.mkIf (config.flake.modules.nixos."boot/grub/wanderer-themes".enable) {
      # NOTE:
      # These services are disabled, since they add A LOT of time to the
      # boot process and almos everything that has something to do with the
      # disk/networking/kernel.
      hardware.bluetooth.powerOnBoot = lib.mkForce false;
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
          theme = lib.mkForce "${inputs.wanderer-grub-theme.packages.${pkgs.stdenv.hostPlatform.system}.grub-theme}";
        };
      };
    };
  };
}
