{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ./wm
    ./launcher
    ./statusbar
    ./lockscreen
    ./idle-daemon
    ./polkitagent
    ./notifications
    ./wallpaper-engine
  ];
  options = {};
  config = {};
}
