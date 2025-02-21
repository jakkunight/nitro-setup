{ lib, config, ... }: {
  imports = [
    ./grub2
    ./systemd.nix
    ./kernel.nix
  ];
  options = {};
  config = {
    bootloader.grub.enable = lib.mkDefault true;
    bootloader.systemd.enable = lib.mkDefault false;
  };
}
