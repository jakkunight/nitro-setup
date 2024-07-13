{ pkgs, ... }@inputs:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      wallpaper = [
        ",~/Pictures/hypr-chan-8K.png"
      ];
    };
  };
}
