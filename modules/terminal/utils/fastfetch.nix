# FastFetch:
{ lib, config, pkgs, ... }: {
  options = {
    terminal.utils.fastfetch = {
      enable = lib.mkEnableOption "Enable FastFetch.";
    };
  };
  config = lib.mkIf config.terminal.utils.fastfetch.enable {
    environment.systemPackages = [
      pkgs.fastfetch
    ];
  };
}
