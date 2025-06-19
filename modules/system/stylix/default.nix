{
  pkgs,
  inputs,
  lib,
  ...
}: {
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-terminal-dark.yaml";
    image = ./scaramouche-sealed-wallpaper.jpg;
    polarity = "dark";
    fonts = {
      serif = {
        package = inputs.genshin-font.packages.${pkgs.system}.default;
        name = "Genshin Impact";
      };

      sansSerif = {
        package = inputs.genshin-font.packages.${pkgs.system}.default;
        name = "Genshin Impact";
      };

      monospace = {
        package = pkgs.nerd-fonts.hack;
        name = "Hack Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
