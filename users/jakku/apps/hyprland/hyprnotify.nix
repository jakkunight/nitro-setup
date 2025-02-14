# Notifications:
{ config, lib, pkgs, ... }:
{
  imports = [];
  options = {};
  config = {
    environment.systemPackages = [
      pkgs.swaynotificationcenter
    ];
  };
}
