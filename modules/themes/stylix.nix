let
  feature = "stylix";
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
        lib,
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
          base16Scheme = lib.mkDefault defaultColorscheme;
          polarity = lib.mkDefault "dark";
          image = lib.mkDefault "${
            self.packages.${pkgs.stdenv.hostPlatform.system}.default-wallpaper
          }/share/wallpapers/default-nix.png";
        };
      };
    homeManager.${feature} =
      {
        pkgs,
        lib,
        ...
      }:
      {
        imports = [
          inputs.stylix.homeModules.stylix
        ];

        stylix = {
          enable = lib.mkDefault true;
          base16Scheme = lib.mkDefault defaultColorscheme;
          polarity = lib.mkDefault "dark";
          image = lib.mkDefault "${
            self.packages.${pkgs.stdenv.hostPlatform.system}.default-wallpaper
          }/share/wallpapers/default-nix.png";
        };
      };
  };
}
