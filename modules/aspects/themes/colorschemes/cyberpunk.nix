let
  feature = "cyberpunk";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyodark-terminal.yaml";
      };
    homeManager =
      { pkgs, ... }:
      {
        stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyodark-terminal.yaml";
      };
  };

}
