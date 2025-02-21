# Zellij configuration:
{ lib, config, pkgs, ... }: {
  options = {
    terminal.multiplexer.zellij = {
      enable = lib.mkEnableOption "Enable Zellij";
    };
  };
  config = lib.mkIf config.terminal.multiplexer.zellij.enable {
    environment.systemPackages = [
      pkgs.zellij
    ];
  };
}
