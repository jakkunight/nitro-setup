let
  feature = "kanagawa-theme";
  # wallpaper = "${self.packages.${pkgs.stdenv.hostPlatform.system}.wanderer-wallpapers}/share/wallpapers/wanderer-scaramouche-aranaras-wallpaper.jpg";
  # wallpaper = "${self.packages.${pkgs.stdenv.hostPlatform.system}.wanderer-wallpapers}/share/wallpapers/AthenaOS-wallpaper.png";

in
{
  inputs,
  self,
  ...
}:
{
  flake.modules = {
    nixos.${feature} =
      {
        pkgs,
        config,
        ...
      }:
      let
        wallpaper = "${
          self.packages.${pkgs.stdenv.hostPlatform.system}.jakkunight-wallpapers
        }/share/wallpapers/jakkunight-wallpaper-9.png";
      in
      {
        imports = with self.modules.nixos; [
          stylix
          kanagawa
        ];

        console = {
          font = "${pkgs.terminus_font}/share/consolefonts/ter-u18b.psf.gz";
          useXkbConfig = true; # use xkb.options in tty.
        };

        stylix = {
          polarity = "dark";
          image = "${wallpaper}";
          fonts = {
            serif = {
              package = pkgs.nerd-fonts.mononoki;
              name = "MononokiNerdFontPropo";
              # package = inputs.genshin-font.packages.${pkgs.stdenv.hostPlatform.system}.default;
              # name = "GenshinImpact";
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
              terminal = 14;
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
            terminal = 0.95;
            desktop = 0.90;
            popups = 0.85;
          };
        };
      };
    homeManager.${feature} =
      {
        pkgs,
        config,
        ...
      }:
      let
        wallpaper = "${
          self.packages.${pkgs.stdenv.hostPlatform.system}.jakkunight-wallpapers
        }/share/wallpapers/jakkunight-wallpaper-9.png";
      in
      {
        imports = with self.modules.homeManager; [
          kanagawa
        ];
        home.pointerCursor.enable = true;
        stylix.targets.qt.enable = false;
        stylix = {
          polarity = "dark";
          image = "${wallpaper}";
          fonts = {
            serif = {
              # package = inputs.genshin-font.packages.${pkgs.stdenv.hostPlatform.system}.default;
              # name = "GenshinImpact";
              package = pkgs.nerd-fonts.mononoki;
              name = "MononokiNerdFontPropo";
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
            applications = 0.90;
            terminal = 0.90;
            desktop = 0.90;
            popups = 0.90;
          };
        };
      };
  };
}
