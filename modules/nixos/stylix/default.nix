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
    base16Scheme = {
      base00 = "#1a1b26";
      base01 = "#16161e";
      base02 = "#2f3549";
      base03 = "#444b6a";
      base04 = "#787c99";
      base05 = "#a9b1d6";
      base06 = "#cbccd1";
      base07 = "#d5d6db";
      base08 = "#c0caf5";
      base09 = "#a9b1d6";
      base0A = "#0db9d7";
      base0B = "#9ece6a";
      base0C = "#b4f9f8";
      base0D = "#2ac3de";
      base0E = "#bb9af7";
      base0F = "#f7768e";
    };
    # {
    #       base00 = "1a1b26";
    #       base01 = "16161e";
    #       base02 = "2f3549";
    #       base03 = "444b6a";
    #       base04 = "787c99";
    #       base05 = "a9b1d6";
    #       base06 = "cbccd1";
    #       base07 = "d5d6db";
    #       base08 = "c0caf5";
    #       base09 = "a9b1d6";
    #       base0A = "0db9d7";
    #       base0B = "9ece6a";
    #       base0C = "b4f9f8";
    #       base0D = "2ac3de";
    #       base0E = "bb9af7";
    #       base0F = "f7768e";
    #     };
    polarity = "dark";
    image = ./wallpaper.jpg;
    fonts = {
      serif = {
        package = inputs.genshin-font.packages.${pkgs.system}.default;
        name = "Genshin Impact";
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
