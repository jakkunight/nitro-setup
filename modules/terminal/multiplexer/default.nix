# Terminal Multiplexers:
{ lib, config, ... }: {
  imports = [
    ./tmux.nix
    ./zellij.nix
  ];
  options = {
    terminal.multiplexer = {
      enable = lib.mkEnableOption "Enable the terminal multiplexers";
    };
  };
  config = lib.mkIf config.terminal.multiplexer.enable {
    terminal.multiplexer = {
      tmux.enable = lib.mkDefault false;
      zellij.enable = lib.mkDefault true;
    };
  };
}
