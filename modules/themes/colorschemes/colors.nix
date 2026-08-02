let
  feature = "colors";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/colors.yaml";
      };
    homeManager.${feature} =
      { pkgs, ... }:
      {
        stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/colors.yaml";
      };
  };
}
