{
  config,
  lib,
  ...
}: let
  inherit (builtins) readDir attrNames;
  configurations = attrNames (readDir ../../../../../configurations/system/terminal/editors/neovim);
in {
  options.modules.system.terminal.editor.neovim = let
    inherit (lib) types mkEnableOption mkOption;
  in {
    enable = mkEnableOption "Weather to enable NeoVim.";
    configuration = mkOption {
      description = "The configuration to use.";
      type = types.nullOr types.enum configurations;
      default = null;
    };
    extraConfiguration = mkOption {
      description = "";
      type = types.nullOr types.attrs;
      default = null;
    };
  };
}
