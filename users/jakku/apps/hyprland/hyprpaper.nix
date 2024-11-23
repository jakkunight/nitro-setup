{ config, pkgs, inputs, ... }:
let bg_file = "";
let monitor1 = "";
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = true;
      splash_offset = 1.0;
      preload = [
        $bg_file
      ];
      wallpaper = [
        "${monitor1},${bg_file}"
      ];
    };
  };
}
