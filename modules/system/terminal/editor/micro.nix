# Micro editor setup:
{ lib, config, pkgs, ... }: {
  options = {
    terminal.editor.micro = {
      enable = lib.mkEnableOption "Enable Micro.";
      default = lib.mkEnableOption "Make Micro your default editor.";
    };
  };
  config = lib.mkIf config.terminal.editor.micro.enable {
    environment = {
      systemPackages = with pkgs; [
        micro
      ];
      sessionVariables = (
        if config.terminal.editor.micro.default 
        then {
          EDITOR = "micro";
        }
        else {}
      );
    };
  };
}
