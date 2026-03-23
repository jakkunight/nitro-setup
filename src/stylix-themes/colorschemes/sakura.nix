let
  feature = "sakura";
  theme = {
    base00 = "33292b";
    base01 = "42383a";
    base02 = "564448";
    base03 = "755f64";
    base04 = "665055";
    base05 = "e0ccd1";
    base06 = "f8e2e7";
    base07 = "feedf3";
    base08 = "df2d52";
    base09 = "f6661e";
    base0A = "c29461";
    base0B = "2e916d";
    base0C = "1d8991";
    base0D = "006e93";
    base0E = "5e2180";
    base0F = "ba0d35";
  };
in
{
  flake.modules = {
    nixos.${feature} = {
      stylix.base16Scheme = theme;
    };
    homeManager.${feature} = {
      stylix.base16Scheme = theme;
    };
  };
}
