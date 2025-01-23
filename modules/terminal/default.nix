# Terminal configuration.
# Theese programs will run for every terminal,
# even in TTy mode.
{ lib, config, pkgs, ... }: {
  imports = [
    ./utils
    ./filemanager
    ./multiplexer
    ./editor
    ./shells
    ./prompts
  ];
  options = {
    terminal = {
      enable = lib.mkEnableOption "Enable the terminal configurations.";
    };
  };
  config = lib.mkIf config.terminal.enable {
    terminal = {
      #utils = {};
      #filemanager = {};
      multiplexer = {
        enable = lib.mkDefault true;
        zellij.enable = true;
      };
      #editor = {};
      #shells = {};
      prompts = {
        enable = true;
        starship.enable = true;
      };
    };
  };
}
