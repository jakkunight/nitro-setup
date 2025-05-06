{
  config,
  pkgs,
  inputs,
  ...
}: let
  db = [
    {
      bg = "~/Pictures/wanderer-wallpaper-fhd.jpg";
      mon = "";
    }
  ];
in {
  config = {
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        preload = map ({
          bg,
          mon,
        }: "${bg}")
        db;
        wallpaper = map ({
          bg,
          mon,
        }: "${mon}, contain:${bg}")
        db;
      };
    };
  };
}
