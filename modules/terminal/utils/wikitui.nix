# WikiTUI, a TUI Wikipedia client:
{ lib, config, pkgs, ... }: {
  options = {
    terminal.utils.wikitui = {
      enable = lib.mkEnableOption "Enable WikiTUI.";
    };
  };
  config = lib.mkIf config.terminal.utils.wikitui.enable {
    environment.systemPackages = [
      pkgs.wiki-tui
    ];
  };
}
