{ configs, pkgs, lib, ... }@inputs:
{
  gtk = {
    enable = true;
    font = {
      name = "Cascadia Code";
      package = pkgs.cascadia-code;
      size = 12;
    };
    theme = {
      name = "Tokyonight";
      package = pkgs.tokyonight-gtk-theme;
    };
    iconTheme = {
      package = pkgs.zafiro-icons;
      name = "Zafiro-icons-Dark";
    };
    cursorTheme = {
      package = pkgs.graphite-cursors;
      name = "graphite-dark";
      size = 18;
    };
  };
}
