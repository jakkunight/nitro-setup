# Notifications:
{ config, lib, pkgs, ... }:
{
  imports = [];
  options = {};
  config = {
    services.swaync = {
      enable = true;
      settings = {
        positionX = "right";
        positionY = "top";
        layer = "overlay";
        control-center-layer = "top";
        layer-shell = true;
        notification-2fa-action = true;
        notification-inline-replies = true;
      };
      style = toString (builtins.readFile ./style.css);
    };
  };
}
