let
  feature = "cyberpunk";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyodark-terminal.yaml";
      };
    homeManager.${feature} =
      { pkgs, ... }:
      {
        stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyodark-terminal.yaml";
      };
  };
}
