let
  feature = "pandora";
in
{
  flake.modules = {
    nixos.${feature} = { pkgs, ... }: {
      stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/pandora.yaml";
    };
    homeManager.${feature} = { pkgs, ... }: {
      stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/pandora.yaml";
    };
  };
}
