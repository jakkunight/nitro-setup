# Termusic, a music player for the terminal written in Rust!
{ lib, config, pkgs, ... }: {
  options = {
    terminal.utils.termusic = {
      enable = lib.mkEnableOption "Enable Termusic.";
    };
  };
  config = lib.mkIf config.terminal.utils.termusic.enable {
    environment.systemPackages = [
      pkgs.termusic
    ];
  };
}

