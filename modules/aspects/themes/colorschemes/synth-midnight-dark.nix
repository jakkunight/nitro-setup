let
  feature = "synth-midnight-dark";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/synth-midnight-dark.yaml";
      };
    homeManager =
      { pkgs, ... }:
      {
        stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/synth-midnight-dark.yaml";
      };
  };

}
