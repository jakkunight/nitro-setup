{ config, lib, pkgs, ... }@inputs:
{
# Hyprlock:
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
      };
      background = [
        {
          monitor = "";
          path = "/home/jakku/Pictures/wanderer-inazuma.jpg";
          color = "rgba(0, 0, 0, 0.5)";
          blur_passes = 1;
          blur_size = 4;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];
      input-field = [
        {
          size = "200, 50";
          monitors = "";
          dots_center = true;
          font_family = "Cascadia Code";
          font_size = 12;
          font_color = "rgb(192, 202, 245)";
          placeholder_text = "<i>Input Password...</i>";
          inner_color = "rgb(157, 124, 216)";
          outer_color = "rgb(36, 40, 59)";
        }
      ];
    };
  };
}
