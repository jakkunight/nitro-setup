let
  feature = "pandora-theme";
  # NOTE:
  # Define here the colors to be used, since the usage of a YAML file will require internet connection (!?) to download the parser.
  defaultColorscheme = {
    # Fondo principal (background)
    base00 = "#3a1d2e";
    # Fondo alternativo (lighter background)
    base01 = "#533948";
    # Fondo de selección (selection background)
    base02 = "#6c5663";
    # Líneas, comentarios (comments, line highlights)
    base03 = "#85727e";
    # Color de fondo para terminal oscura (dark terminal background)
    base04 = "#9f8f99";
    # Color de texto principal (foreground)
    base05 = "#b8abb4";
    # Color de texto secundario (light foreground)
    base06 = "#d1c8cf";
    # Fondo claro / texto invertido (light background / inverted text)
    base07 = "#ebe5ea";
    # Rojo / variables, errores (red, variables, errors)
    base08 = "#9e345e";
    # Naranja / constantes, números (orange, constants, numbers)
    base09 = "#ba6386";
    # Amarillo / atributos, clases (yellow, attributes, classes)
    base0A = "#80ba77";
    # Verde / cadenas, strings (green, strings)
    base0B = "#0d8438";
    # Cian / títulos, soporte (cyan, titles, support)
    base0C = "#6dcfa8";
    # Azul / funciones, métodos (blue, functions, methods)
    base0D = "#94509e";
    # Magenta / palabras clave (magenta, keywords)
    base0E = "#8c2862";
    # Marrón / deprecated, eliminado (brown, deprecated, deleted)
    base0F = "#9f486e";
    # Base10: fondo de menús, resaltado (menus, highlighted background)
    base10 = "#824f63";
    # Base11: bordes, separadores (borders, separators)
    base11 = "#a3798a";
    # Base12: rojo brillante (bright red)
    base12 = "#8ca888";
    # Base13: verde brillante (bright green)
    base13 = "#2b6540";
    # Base14: amarillo brillante (bright yellow)
    base14 = "#85b6a2";
    # Base15: azul brillante (bright blue)
    base15 = "#85638a";
    # Base16: magenta brillante (bright magenta)
    base16 = "#72415d";
    # Base17: cian brillante (bright cyan)
    base17 = "#885e70";
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
