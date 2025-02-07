{ config, lib, inputs, pkgs, ... }:
{
  options = {
    serv.flatpak = {
      enable = lib.mkEnableOption "Enable Flatpak service.";
    };
  };
  config = lib.mkIf config.serv.flatpak.enable {
    service.flatpak.enable = true;
  };
}
