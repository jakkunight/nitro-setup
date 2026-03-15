let
  feature = "kanagawa-theme";
  # NOTE:
  # Define here the colors to be used, since the usage of a YAML file will require internet connection (!?) to download the parser.
  defaultColorscheme = {
    # --- Base backgrounds ---
    base00 = "1F1F28"; # Default background (editor background)
    base01 = "16161D"; # Deeper background (statusline, splits)
    base02 = "223249"; # Selection background / visual mode
    base03 = "54546D"; # Comments / muted / disabled text

    # --- Base foregrounds ---
    base04 = "727169"; # Secondary foreground (UI text, line numbers)
    base05 = "DCD7BA"; # Default foreground (main text)
    base06 = "C8C093"; # Emphasized foreground (headings, strong text)
    base07 = "E6E0C5"; # Brightest foreground (active UI focus)

    # --- Syntax / semantic accents ---
    base08 = "C34043"; # Errors, deleted diff, invalid syntax
    base09 = "FFA066"; # Warnings, numbers, constants
    base0A = "C0A36E"; # Types, classes, attributes
    base0B = "76946A"; # Strings, success states, added diff
    base0C = "6A9589"; # Support, builtins, escape sequences
    base0D = "7E9CD8"; # Functions, methods, links
    base0E = "957FB8"; # Keywords, control flow, storage
    base0F = "D27E99"; # Special, tags, decorators, regex

    # --- Base24 extensions ---

    base10 = "14141B"; # True background (terminal background / padding)
    base11 = "2A2A37"; # Elevated surface (panels, popups, floating windows)

    base12 = "F2EDDA"; # High-contrast foreground (cursor text, selected fg)
    base13 = "8A8A9A"; # Muted UI text (folds, inactive elements)

    base14 = "E46876"; # Strong error (critical diagnostics)
    base15 = "FFB37F"; # Strong warning / attention highlight

    base16 = "5F7DBA"; # Active highlight (current line border, focus ring)
    base17 = "B39BD6"; # Accent highlight (search match, special emphasis)
  };
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
      {
        imports = [
          self.modules.nixos.stylix
        ];

        console = {
          font = "${pkgs.terminus_font}/share/consolefonts/ter-u18b.psf.gz";
          useXkbConfig = true; # use xkb.options in tty.
        };

        stylix = {
          base16Scheme = defaultColorscheme;
          polarity = "dark";
          image = "${
            self.packages.${pkgs.stdenv.hostPlatform.system}.wanderer-wallpapers
          }/share/wallpapers/wanderer-traditional-japanese-picture.jpg";
          fonts = {
            serif = {
              package = inputs.genshin-font.packages.${pkgs.stdenv.hostPlatform.system}.default;
              name = "GenshinImpact";
            };

            sansSerif = config.stylix.fonts.serif;

            monospace = {
              package = pkgs.nerd-fonts.caskaydia-mono;
              name = "CaskaydiaMonoNerdFontPropo";
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
            terminal = 0.90;
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
      {
        imports = [
          self.modules.homeManager.stylix
        ];

        stylix = {
          base16Scheme = defaultColorscheme;
          polarity = "dark";
          image = "${
            self.packages.${pkgs.stdenv.hostPlatform.system}.wanderer-wallpapers
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
        };
      };
  };
}
