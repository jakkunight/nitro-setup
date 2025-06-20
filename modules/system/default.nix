{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./bootloader
    ./disk
    ./audio
    ./terminal
    ./net
    ./services
    ./graphics
    ./gaming
    ./development
  ];
  config = {
    #### Install basic programs ####

    environment.systemPackages = [
      pkgs.git
      pkgs.nixos-generators
      pkgs.nh
      pkgs.sops
      pkgs.zed-editor
    ];

    #### ====================== ####

    #### Install ALL hhardware and firmware ####

    hardware = {
      enableAllHardware = true;
      enableAllFirmware = true;
      enableRedistributableFirmware = true;
    };

    #### ================================== ####
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
    development.enable = lib.mkDefault true;
  };
}
