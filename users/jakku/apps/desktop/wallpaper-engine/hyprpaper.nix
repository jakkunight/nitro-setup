_: let
  db = [
    {
      bg = "~/Pictures/wanderer-aranaras.jpg";
      mon = "";
    }
  ];
in {
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
      }: "${mon}, ${bg}")
      db;
    };
  };
}
