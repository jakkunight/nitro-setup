let
  feature = "kanagawa-theme";
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
        lib,
        config,
        ...
      }:
      {
        imports = [
          inputs.stylix.nixosModules.stylix
        ];

        console = {
          font = "${pkgs.terminus_font}/share/consolefonts/ter-u18b.psf.gz";
          useXkbConfig = true; # use xkb.options in tty.
        };

        stylix = {
          enable = true;
          base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
          polarity = "dark";
          image = "${
            self.packages.${pkgs.stdenv.system}.wanderer-wallpapers
          }/share/wallpapers/wanderer-traditional-japanese-picture.jpg";
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
            terminal = 0.80;
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
      };
    homeManager.${feature} =
      {
        pkgs,
        lib,
        config,
        ...
      }:
      {
        imports = [
          inputs.stylix.homeModules.stylix
        ];

        stylix = {
          enable = true;
          base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
          polarity = "dark";
          image = "${
            self.packages.${pkgs.stdenv.system}.wanderer-wallpapers
          }/share/wallpapers/wanderer-traditional-japanese-picture.jpg";
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
            terminal = 0.80;
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
      };
  };
}
