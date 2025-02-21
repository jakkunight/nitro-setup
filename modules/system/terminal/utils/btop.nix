# BTOP:
{ lib, config, pkgs, ... }: {
  options = {
    terminal.utils.btop = {
      enable = lib.mkEnableOption "Enable BTOP.";
    };
  };
  config = lib.mkIf config.terminal.utils.btop.enable {
    environment.systemPackages = [
      pkgs.btop
    ];
  };
}
