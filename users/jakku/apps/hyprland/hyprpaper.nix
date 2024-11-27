{ config, pkgs, inputs, ... }:
let
  bg_file = "~/Pictures/furina-bubles-background.jpg";
  monitor1 = "";
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = true;
      splash_offset = 1.0;
      preload = [
        "${bg_file}"
      ];
      wallpaper = [
        "${monitor1},${bg_file}"
      ];
    };
  };
}
