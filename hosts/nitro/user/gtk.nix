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
      name = "Tokyonight-Dark-B";
      package = pkgs.tokyonight-gtk-theme;
    };
    iconTheme = {
      package = pkgs.tokyonight-gtk-theme;
      name = "Tokyonight-Dark-B";
    };
    cursorTheme = {
      package = pkgs.tokyonight-gtk-theme;
      name = "Tokyonight-Dark-B";
      size = 18;
    };
  };
}
