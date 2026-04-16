let
  feature = "kanagawa";
  theme = {
    # Meta:
    slug = "kanagawa";
    scheme = "Kanagawa";
    author = "Jakku Night";
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
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        # stylix.base16Scheme = theme;
        stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
      };
    homeManager.${feature} =
      { lib, pkgs, ... }:
      {
        # stylix.base16Scheme = theme;
        # programs.helix.settings.theme = lib.mkForce "kanagawa";
        stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
      };
  };
}
