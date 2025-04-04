# Terminal configuration.
# Theese programs will run for every terminal,
# even in TTy mode.
{
  lib,
  config,
  pkgs,
  ...
}: {
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
    environment.systemPackages = with pkgs; [
      wl-clipboard
      xclip
    ];
    terminal = {
      #utils = {};
      filemanager = {};
      multiplexer = {
        enable = lib.mkDefault true;
        zellij.enable = true;
      };
      editor = {
        enable = lib.mkDefault true;
      };
      shells = {
        enable = lib.mkDefault true;
        zsh = {
          enable = lib.mkDefault true;
          default = lib.mkDefault true;
        };
      };
      prompts = {
        enable = true;
        starship.enable = true;
      };
      utils = {
        enable = lib.mkDefault true;
      };
    };
  };
}
