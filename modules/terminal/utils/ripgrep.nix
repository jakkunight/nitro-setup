# Netscanner:
{ lib, config, pkgs, ... }: {
  options = {
    terminal.utils.ripgrep = {
      enable = lib.mkEnableOption "Enable RipGrep.";
    };
  };
  config = lib.mkIf config.terminal.utils.ripgrep.enable {
    environment.systemPackages = [
      pkgs.ripgrep
    ];
  };
}
