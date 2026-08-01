let
  feature = "synth-midnight-dark";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/synth-midnight-dark.yaml";
      };
    homeManager.${feature} =
      { pkgs, ... }:
      {
        stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/synth-midnight-dark.yaml";
      };
  };
}
