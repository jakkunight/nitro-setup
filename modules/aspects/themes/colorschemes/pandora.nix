let
  feature = "pandora";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos = { pkgs, ... }: {
      stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/pandora.yaml";
    };
    homeManager = { pkgs, ... }: {
      stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/pandora.yaml";
    };
  };

}
