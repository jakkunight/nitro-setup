{ lib, config, ... }: {
  imports = [
    ./grub2
    ./systemd.nix
  ];
  options = {};
  config = {
    bootloader.grub.enable = lib.mkDefault true;
    bootloader.systemd.enable = lib.mkDefault false;
  };
}
