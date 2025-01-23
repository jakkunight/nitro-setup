{ lib, config, ... }: {
  imports = [
    ./bootloader
    ./disk
    ./audio
  ];
  config = {
    bootloader.grub.enable = lib.mkDefault true;
    bootloader.systemd.enable = lib.mkDefault false;
    audio.enable = lib.mkDefault true;
  };
}
