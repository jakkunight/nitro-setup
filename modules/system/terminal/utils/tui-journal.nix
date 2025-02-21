# TUIU-journal, a TUI app to mange notes and tasks:
{ lib, config, pkgs, ... }: {
  options = {
    terminal.utils.tui-journal = {
      enable = lib.mkEnableOption "Enable .";
    };
  };
  config = lib.mkIf config.terminal.utils.tui-journal.enable {
    environment.systemPackages = [
      pkgs.tui-journal
    ];
  };
}
