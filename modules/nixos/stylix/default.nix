{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: {
  stylix = {
    enable = true;
    # scheme = "Tokyonight";
    # author = "Folke Lemaitre (https://github.com/folke)";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa-dragon.yaml";
    polarity = "dark";
    image = ./wallpaper.jpg;
    fonts = {
      serif = {
        package = inputs.genshin-font.packages.${pkgs.system}.default;
        name = "GenshinImpact";
      };

      sansSerif = config.stylix.fonts.serif;

      monospace = {
        package = pkgs.nerd-fonts.mononoki;
        name = "MononokiNerdFontMono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 12;
        terminal = 14;
        desktop = 12;
        popups = 12;
      };
    };
    opacity = {
      applications = 0.95;
      terminal = 0.75;
      desktop = 0.85;
      popups = 0.95;
    };
    targets = {
      qt = {
        enable = true;
        platform = lib.mkForce "qtct";
      };
    };
  };
  # qt = {
  #   enable = true;
  #   platformTheme = "gtk2";
  #   style = "gtk2";
  # };
}
