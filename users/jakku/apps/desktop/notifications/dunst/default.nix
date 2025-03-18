{ config, lib, pkgs, ... }:
{
  config = {
    services.dunst = {
      enable = true;
    };
  };
}
