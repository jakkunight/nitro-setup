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
  cfg = config.configurations.system.stylix.style;
in {
  options = {
    configurations.system.stylix.style = lib.mkOptionType {
      type = lib.types.nullOr lib.types.enum (builtins.attrNames styles);
      default = null;
      description = "Select a theme for your Stylix setup.";
    };
  };
  imports = lib.optionals (styles ? ${cfg.style}) [
    cfg.style
  ];
}
