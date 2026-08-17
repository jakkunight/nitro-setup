let
  feature = "cyberpunk-theme";
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
          self.packages.${pkgs.stdenv.hostPlatform.system}.wanderer-wallpapers
        }/share/wallpapers/wanderer-scaramouche-aranaras-wallpaper.jpg";
      in
      {
        imports = with self.modules.nixos; [
          stylix
          cyberpunk
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
              applications = 16;
              terminal = 16;
              desktop = 16;
              popups = 16;
            };
          };
          cursor = {
            package = self.packages.${pkgs.stdenv.hostPlatform.system}.wanderer-cursors;
            name = "Wanderer";
            size = 36;
          };
          icons = {
            enable = true;
            package = self.packages.${pkgs.stdenv.hostPlatform.system}.colorful-icons;
            dark = "Colorful-Dark-Icons";
            light = "Colorful-Dark-Icons";
          };
          opacity = {
            applications = 0.90;
            terminal = 0.90;
            desktop = 0.90;
            popups = 0.90;
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
          self.packages.${pkgs.stdenv.hostPlatform.system}.wanderer-wallpapers
        }/share/wallpapers/wanderer-scaramouche-aranaras-wallpaper.jpg";
      in
      {
        imports = with self.modules.homeManager; [
          cyberpunk
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
              applications = 16;
              terminal = 16;
              desktop = 16;
              popups = 16;
            };
          };
          cursor = {
            package = self.packages.${pkgs.stdenv.hostPlatform.system}.wanderer-cursors;
            name = "Wanderer";
            size = 36;
          };
          icons = {
            enable = true;
            package = self.packages.${pkgs.stdenv.hostPlatform.system}.colorful-icons;
            dark = "Colorful-Dark-Icons";
            light = "Colorful-Dark-Icons";
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
