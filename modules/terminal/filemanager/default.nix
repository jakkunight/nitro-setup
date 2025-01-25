# Terminal filemanagers:
{ lib, config, ... }: {
  imports = [
    ./yazi.nix
  ];
  options = {
    terminal.filemanager = {
      enable = lib.mkEnableOption "Enable a terminal filemanager";
    };
  };
  config = lib.mkIf config.terminal.filemanager.enable {
    terminal.filemanager = {
      yazi.enable = lib.mkDefault true;
    };
  };
}
