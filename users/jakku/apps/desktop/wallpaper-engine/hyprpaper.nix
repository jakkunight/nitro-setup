_: let
  db = [
    {
      bg = "~/Pictures/wanderer-aranaras.jpg";
      mon = "";
    }
    {
      bg = "~/Pictures/wanderer-wallpaper-fhd.jpg";
      mon = "";
    }
    {
      bg = "~/Pictures/wanderer-human-durin-wallpaper-4k.jpg";
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
