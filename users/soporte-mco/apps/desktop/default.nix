{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ./wm
    ./launcher
    ./statusbar
    ./lockscreen
    ./polkitagent
    ./idle-daemon
    ./notifications
    ./wallpaper-engine
  ];
  options = {};
  config = {};
}
