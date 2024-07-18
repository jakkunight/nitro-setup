# GTK config:
{ pkgs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.breeze-hacked-cursor-theme;
    name = "Breeze_Hacked"; # See https://store.kde.org/p/1440328 to find the selector name.
    size = 48;
  };

  gtk = {
    enable = true;
    font = {
      name = "Cascadia Code";
      package = pkgs.cascadia-code;
      size = 12;
    };
    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme;
    };
    iconTheme = {
      package = pkgs.candy-icons;
      name = "candy-icons";
    };
    cursorTheme = {
      package = pkgs.breeze-hacked-cursor-theme;
      name = "Breeze_Hacked"; # See https://store.kde.org/p/1440328 to find the selector name.
      size = 48;
    };
  };
}
