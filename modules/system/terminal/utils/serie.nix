# Serie:
{ lib, config, pkgs, ... }: {
  options = {
    terminal.utils.serie = {
      enable = lib.mkEnableOption "Enable Serie.";
    };
  };
  config = lib.mkIf config.terminal.utils.serie.enable {
    environment.systemPackages = [
      pkgs.serie
    ];
  };
}

