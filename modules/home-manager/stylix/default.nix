{
  config,
  inputs,
  pkgs,
  ...
}: {
  # Stylix:
  stylix = {
    enable = true;
    # scheme = "Tokyonight";
    # author = "Folke Lemaitre (https://github.com/folke)";
    # base16Scheme = {
    #   system = "base24";
    #   name = "Tokyo Night Night";
    #   author = "Jakku Night";
    #   variant = "dark";
    #   base00 = "#1a1b26";
    #   base01 = "#16161e";
    #   base02 = "#444b6a";
    #   base03 = "#636da6";
    #   base04 = "#787c99";
    #   base05 = "#a9b1d6";
    #   base06 = "#cbccd1";
    #   base07 = "#d5d6db";
    #   base08 = "#ff757f";
    #   base09 = "#ffc777";
    #   base0A = "#f6955b";
    #   base0B = "#9ece6a";
    #   base0C = "#86e1fc";
    #   base0D = "#82aaff";
    #   base0E = "#bb9af7";
    #   base0F = "#d18616";
    #   base10 = "#c53b53";
    #   base11 = "#ff9e64";
    #   base12 = "#e0af68";
    #   base13 = "#c3e88d";
    #   base14 = "#b4f9f8";
    #   base15 = "#7199ee";
    #   base16 = "#fca7ea";
    #   base17 = "#773440";
    # };
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
      firefox = {
        colorTheme.enable = true;
        profileNames = [
          "default"
        ];
      };
      zen-browser = {
        profileNames = [
          "default"
        ];
      };
      qt = {
        enable = true;
        platform = "qtct";
      };
    };
  };
}
