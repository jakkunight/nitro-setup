# GTK config:
{ pkgs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.breeze-hacked-cursor-theme;
    name = "Breeze_Hacked"; # See https://store.kde.org/p/1440328 to find the selector name.
    size = 36;
  };

  gtk = {
    enable = true;
    font = {
      name = "Genshin Impact";
      package = inputs.genshin-font.packages.${pkgs.system}.default;
      size = 14;
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
      size = 36;
    };
  };
}
