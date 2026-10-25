let
  feature = "kanagawa-theme";
  # wallpaper = "${self.packages.${pkgs.stdenv.hostPlatform.system}.wanderer-wallpapers}/share/wallpapers/wanderer-scaramouche-aranaras-wallpaper.jpg";
  # wallpaper = "${self.packages.${pkgs.stdenv.hostPlatform.system}.wanderer-wallpapers}/share/wallpapers/AthenaOS-wallpaper.png";

in
{
  inputs,
  self,
  den,
  ...
}:
{
  den.aspects.${feature} = {
    nixos =
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
        imports =
          with den.aspects;
          map
            (
              a:
              if builtins.isAttrs a && a ? nixos then
                (
                  let
                    v = a.nixos;
                  in
                  if builtins.isAttrs v && v ? __contentValues then
                    { imports = map (d: d.value) v.__contentValues; }
                  else
                    v
                )
              else if builtins.isAttrs a && a ? provides then
                { }
              else
                a
            )
            [
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
              package = pkgs.nerd-fonts.hack;
              name = "Hack Nerd Font";
              # name = "GenshinImpact";
            };

            sansSerif = config.stylix.fonts.serif;

            monospace = {
              package = pkgs.nerd-fonts.hack;
              name = "Hack Nerd Font Mono";
            };

            emoji = {
              package = pkgs.noto-fonts-color-emoji;
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
    homeManager =
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
        imports =
          with den.aspects;
          map
            (
              a:
              if builtins.isAttrs a && a ? homeManager then
                (
                  let
                    v = a.homeManager;
                  in
                  if builtins.isAttrs v && v ? __contentValues then
                    { imports = map (d: d.value) v.__contentValues; }
                  else
                    v
                )
              else if builtins.isAttrs a && a ? provides then
                { }
              else
                a
            )
            [
              kanagawa
            ];
        home.pointerCursor.enable = true;
        stylix.targets.qt.enable = false;
        stylix = {
          polarity = "dark";
          image = "${wallpaper}";
          fonts = {
            serif = {
              package = pkgs.nerd-fonts.hack;
              name = "Hack Nerd Font";
            };

            sansSerif = config.stylix.fonts.serif;

            monospace = {
              package = pkgs.nerd-fonts.hack;
              name = "Hack Nerd Font Mono";
            };

            emoji = {
              package = pkgs.noto-fonts-color-emoji;
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
