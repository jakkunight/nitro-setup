# TLDR, better manpages:
{ lib, config, pkgs, ... }: {
  options = {
    terminal.utils.tldr = {
      enable = lib.mkEnableOption "Enable TLDR.";
    };
  };
  config = lib.mkIf config.terminal.utils.tldr.enable {
    environment.systemPackages = [
      pkgs.tldr
    ];
  };
}
