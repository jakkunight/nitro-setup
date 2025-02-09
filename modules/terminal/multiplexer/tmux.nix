# TMUX configuration:
{ lib, config, pkgs, ... }: {
  options = {
    terminal.multiplexer.tmux = {
      enable = lib.mkEnableOption "Enable TMUX.";
    };
  };
  config = lib.mkIf config.terminal.multiplexer.tmux.enable {
    programs.tmux = {
      enable = true;
      clock24 = true;
      shortcut = "a";
      terminal = "screen";
      historyLimit = 5000;
      keyMode = "vi";
      plugins = with pkgs.tmuxPlugins; [
        battery
        continuum
        cpu
        mode-indicator
        net-speed
        online-status
        # resurrect
        tokyo-night-tmux
      ];
    };
  };
}
