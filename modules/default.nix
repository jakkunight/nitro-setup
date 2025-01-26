{ lib, config, pkgs, ... }: {
  imports = [
    ./bootloader
    ./disk
    ./audio
    ./terminal
  ];
  config = {
    #### Install basic programs ####

    environment.systemPackages = [
      pkgs.git
      pkgs.nixos-generators
    ];

    #### ====================== ####
    bootloader = {
      grub.enable = lib.mkDefault true;
      systemd.enable = lib.mkDefault false;
    };
    audio.enable = lib.mkDefault true;
    terminal.enable = lib.mkDefault true;
  };
}
