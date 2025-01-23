{ lib, config, ... }: {
  imports = [
    ./bootloader
    ./disk
    ./audio
    ./terminal
  ];
  config = {
    bootloader = {
      grub.enable = lib.mkDefault true;
      systemd.enable = lib.mkDefault false;
    };
    audio.enable = lib.mkDefault true;
    terminal = {
      enable = lib.mkDefault true;
      multiplexer = {
        enable = lib.mkDefault true;
      };
      prompts = {
        enable = lib.mkDefault true;
      };
    };
  };
}
