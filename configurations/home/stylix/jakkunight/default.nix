{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  styles = {
    jakkunight = ./styles/jakkunight.nix;
  };
in {
  options = {
    configurations.system.stylix.style = lib.mkOptionType {
      type = lib.types.nullOr lib.types.enum (builtins.attrNames styles);
      default = null;
      description = "Select a theme for your Stylix setup.";
    };
  };
  imports = lib.optionals (styles ? ${config.configurations.system.stylix.style}) [
    config.configurations.system.stylix.style
  ];
}
