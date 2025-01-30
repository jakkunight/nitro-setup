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
      preload = [
        "${bg_file}"
      ];
      wallpaper = [
        "${monitor1}, contain:${bg_file}"
      ];
    };
  };
}
