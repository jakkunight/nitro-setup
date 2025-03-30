{ config, lib, pkgs, ... }: {
  options = {
    terminal.utils.rmpc = {
      enable = lib.mkEnableOption "Enable RMPC";
    };
  };
  config = lib.mkIf config.terminal.utils.rmpc.enable {
    environment.systemPackages = [
      pkgs.rmpc
    ];
  };
}
