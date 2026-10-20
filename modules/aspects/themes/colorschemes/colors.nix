let
  feature = "colors";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/colors.yaml";
      };
    homeManager =
      { pkgs, ... }:
      {
        stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/colors.yaml";
      };
  };

}
