# Bat, a cat with wings:
{ lib, config, pkgs, ... }: {
  options = {
    terminal.utils.bat = {
      enable = lib.mkEnableOption "Enable Bat.";
    };
  };
  config = lib.mkIf config.terminal.utils.bat.enable {
    environment.systemPackages = [
      pkgs.bat
    ];
  };
}
