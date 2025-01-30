{ lib, config, pkgs, ... }: {
  imports = [
    ./bootloader
    ./disk
    ./audio
    ./terminal
    ./net
    ./services
    ./graphics
    ./gaming
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
    net.enable = lib.mkDefault true;
    serv.enable = lib.mkDefault true;
    graphics.enable = lib.mkDefault false;
    gaming.enable = lib.mkDefault false;
  };
}
