{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "chafa";
        width = 48;
        height = 20;
        source = "~/Pictures/jakku-profile.png";
      };
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "shell"
        "display"
        "de"
        "wm"
        "wmtheme"
        "theme"
        "icons"
        "font"
        "cursor"
        "terminal"
        "terminalfont"
        "cpu"
        "gpu"
        "memory"
        "swap"
        "disk"
        "localip"
        "battery"
        "poweradapter"
        "locale"
        "break"
        "colors"
      ];
    };
  };
}
