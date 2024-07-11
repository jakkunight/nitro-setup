{ configs, pkgs, lib, ... }@inputs:
{
  gtk = {
    enable = true;
    font = {
      name = "Cascadia Code";
      package = pkgs.cascadia-code;
      #size = "14pt";
    };
    theme = {
      name = "Tokyonight";
      package = pkgs.tokyonight-gtk-theme;
    };
  };
}
