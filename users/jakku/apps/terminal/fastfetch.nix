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
        type = "auto";
        color = {
          "1" = "#7dcfff";
        };
        width = 32;
        height = 32;
        source = "~/Pictures/jakku-profile.txt";
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
