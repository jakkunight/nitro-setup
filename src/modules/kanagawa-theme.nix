let
  moduleName = "kanagawa-theme";
in
  {
    inputs,
    self,
    withSystem,
    ...
  }: {
    flake.nixosModules.${moduleName} = {
      config,
      pkgs,
      lib,
      ...
    }: {
      imports = [
        inputs.stylix.nixosModules.stylix
      ];
      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
        image = "${withSystem pkgs.stdenv.hostPlatform.system self.packages.wallpapers}/share/wallpapers/wanderer-scaramouche-sumeru.jpg";
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
          terminal = 0.90;
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
    flake.homeModules.${moduleName} = {
      config,
      pkgs,
      lib,
      ...
    }: {
      imports = [
        inputs.stylix.homeModules.stylix
      ];
      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
        image = "${self.packages.${pkgs.stdenv.hostPlatform.system}.wallpapers}/share/wallpapers/wanderer-scaramouche-sumeru.jpg";
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
          terminal = 0.90;
          desktop = 0.85;
          popups = 0.85;
        };
        targets = {
          qt = {
            enable = true;
            platform = lib.mkForce "qtct";
          };
          kitty.variant256Colors = true;
          firefox = {
            colorTheme.enable = true;
            profileNames = [
              "default"
            ];
          };
          zen-browser = {
            enable = true;
            enableCss = true;
            profileNames = [
              "default"
            ];
          };
        };
      };
    };
  }
