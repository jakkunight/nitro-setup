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
    image = ./wallpapers/hypr-chan-v2.png;
    fonts = {
      serif = {
        package = inputs.genshin-font.packages.${pkgs.system}.default;
        name = "GenshinImpact";
      };

      sansSerif = config.stylix.fonts.serif;

      monospace = {
        package = pkgs.nerd-fonts.mononoki;
        name = "MononokiNerdFontPropo";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 12;
        terminal = 16;
        desktop = 12;
        popups = 12;
      };
    };
    cursor = {
      package = pkgs.lyra-cursors;
      name = "LyraB-cursors";
      size = 32;
    };
    icons = {
      enable = true;
      package = pkgs.kanagawa-icon-theme;
      dark = "Kanagawa";
      light = "Kanagawa";
    };
    opacity = {
      applications = 0.95;
      terminal = 0.85;
      desktop = 0.85;
      popups = 0.85;
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
