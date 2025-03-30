# Helix editor setup:
{ lib, config, pkgs, ... }: {
  options = {
    terminal.editor.helix = {
      enable = lib.mkEnableOption "Enable Helix.";
      default = lib.mkEnableOption "Make Helix your default editor.";
    };
  };
  config = lib.mkIf config.terminal.editor.helix.enable {
    environment = {
      systemPackages = [
        pkgs.helix
      ];
      sessionVariables = (
        if config.terminal.editor.helix.default 
        then {
          EDITOR = "hx";
        }
        else {}
      );
    };
  };
}
