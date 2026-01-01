{inputs, ...}: let
  wallpaper = ./wallpapers/default.jpg;
  palette = "tokyo-night-dark";
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
      base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/${palette}.yaml";
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
      base16Scheme = lib.mkForce "${pkgs.base16-schemes}/share/themes/${palette}.yaml";
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
        terminal = 0.70;
        desktop = 0.40;
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
