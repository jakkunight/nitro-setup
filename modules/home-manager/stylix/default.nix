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
    #   base00 = "#15161e";
    #   base01 = "#f7768e";
    #   base02 = "#9ece6a";
    #   base03 = "#e0af68";
    #   base04 = "#7aa2f7";
    #   base05 = "#bb9af7";
    #   base06 = "#7dcfff";
    #   base07 = "#a9b1d6";
    #   base08 = "#414868";
    #   base09 = "#ff899d";
    #   base0A = "#9fe044";
    #   base0B = "#faba4a";
    #   base0C = "#8db0ff";
    #   base0D = "#c7a9ff";
    #   base0E = "#a4daff";
    #   base0F = "#c0caf5";
    # };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyodark.yaml";
    polarity = "dark";
    image = ./wallpaper.jpg;
    fonts = {
      serif = {
        package = inputs.genshin-font.packages.${pkgs.system}.default;
        name = "GenshinImpact";
      };

      sansSerif = config.stylix.fonts.serif;

      monospace = {
        package = pkgs.nerd-fonts.hack;
        name = "HackNerdFontMono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 12;
        terminal = 12;
        desktop = 12;
        popups = 12;
      };
    };
    cursor = {
      package = pkgs.breeze-hacked-cursor-theme;
      name = "Breeze_Hacked";
      size = 36;
    };
    opacity = {
      applications = 1.0;
      terminal = 1.0;
      desktop = 0.8;
      popups = 0.8;
    };
    iconTheme = {
      enable = true;
      package = pkgs.candy-icons;
      dark = "candy-icons";
      light = "candy-icons";
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
