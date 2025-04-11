# Bottles!
{ lib, config, pkgs, ... }:
{
  options = {
    gaming.bottles = {
      enable = lib.mkEnableOption "Enable Bottles!";
    };
  };
  config = lib.mkIf config.gaming.bottles.enable {
    environment.systemPackages = [
      pkgs.bottles
    ];
  };
}
