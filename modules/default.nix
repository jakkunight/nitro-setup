{ lib, config, ... }: {
  imports = [
    ./bootloader
    ./disk
  ];
  config = {
    bootloader.grub.enable = true;
    bootloader.systemd.enable = false;
  };
}
