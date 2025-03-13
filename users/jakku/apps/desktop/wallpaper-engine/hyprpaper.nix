{ config, pkgs, inputs, ... }:
let
  bg_file = "~/Pictures/wanderer-genshin-impact-splash-trailer.jpg";
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
