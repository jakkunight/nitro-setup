{inputs, ...}: let
  wallpaper = ./wallpapers/version-luna-iii-launcher-animation-durin.png;
  palette = "tokyo-night-dark";
  colorScheme = pkgs:
    if palette == "" || palette == null
    then {
      base00 = "1a1b26"; # Background
      base01 = "16161e"; # Lighter background (terminal black)
      base02 = "2f3549"; # Selection background
      base03 = "444b6a"; # Comments, invisibles
      base04 = "787c99"; # Dark foreground
      base05 = "a9b1d6"; # Default foreground
      base06 = "cbccd1"; # Light foreground
      base07 = "d5d6db"; # Lightest foreground
      base08 = "c0caf5"; # Variables, XML tags
      base09 = "a9b1d6"; # Integers, booleans
      base0A = "0db9d7"; # Classes, search text bg
      base0B = "9ece6a"; # Strings
      base0C = "b4f9f8"; # Regex, escape chars
      base0D = "2ac3de"; # Functions, methods
      base0E = "bb9af7"; # Keywords, storage
      base0F = "f7768e"; # Deprecated, special
      base10 = "16161e"; # Darker background
      base11 = "0f0f14"; # Darkest background
      base12 = "ff7a93"; # Bright red
      base13 = "ff9e64"; # Bright orange
      base14 = "73daca"; # Bright green/teal
      base15 = "7dcfff"; # Bright cyan
      base16 = "89ddff"; # Bright blue
      base17 = "bb9af7"; # Bright magenta
    }
    else "${pkgs.base16-schemes}/share/themes/${palette}.yaml";
in {
  flake.modules.nixos."theming/stylix/nightmare" = {
    pkgs,
    config,
    lib,
    ...
  }: {
    imports = [
      inputs.stylix.nixosModules.stylix
    ];

    console = {
      font = "${pkgs.terminus_font}/share/consolefonts/ter-v24b.psf.gz";
      useXkbConfig = true; # use xkb.options in tty.
    };

    stylix = {
      enable = true;
      base16Scheme = lib.mkDefault (colorScheme pkgs);
      polarity = "dark";
      image = wallpaper;
      fonts = {
        serif = {
          package = inputs.genshin-font.packages.${pkgs.stdenv.hostPlatform.system}.default;
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
          desktop = 14;
          popups = 12;
        };
      };
      cursor = {
        package = pkgs.afterglow-cursors-recolored;
        name = "Afterglow-Recolored-Dracula-Cyan";
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
        terminal = 0.70;
        desktop = 0.60;
        popups = 0.85;
      };
      targets = {
        qt = {
          enable = true;
          platform = lib.mkForce "qtct";
        };
      };
    };
  };
  flake.modules.homeManager."theming/stylix/nightmare" = {
    pkgs,
    config,
    lib,
    ...
  }: {
    stylix = {
      enable = true;
      base16Scheme = lib.mkForce (colorScheme pkgs);
      polarity = "dark";
      image = wallpaper;
      fonts = {
        serif = {
          package = inputs.genshin-font.packages.${pkgs.stdenv.hostPlatform.system}.default;
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
        package = pkgs.afterglow-cursors-recolored;
        name = "Afterglow-Recolored-Dracula-Cyan";
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
        terminal = 0.80;
        desktop = 0.80;
        popups = 0.85;
      };
      targets = {
        kitty.variant256Colors = true;
        firefox = {
          colorTheme.enable = true;
          profileNames = [
            "default"
          ];
        };
        zen-browser = {
          enable = false;
          enableCss = true;
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
  };
}
