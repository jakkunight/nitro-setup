# MProcs:
{ lib, config, pkgs, ... }: {
  options = {
    terminal.utils.mprocs = {
      enable = lib.mkEnableOption "Enable MProcs.";
    };
  };
  config = lib.mkIf config.terminal.utils.mprocs.enable {
    environment.systemPackages = [
      pkgs.mprocs
    ];
  };
}

