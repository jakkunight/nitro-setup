# GiTUI:
{ lib, config, pkgs, ... }: {
  options = {
    terminal.utils.gitui = {
      enable = lib.mkEnableOption "Enable GiTUI.";
    };
  };
  config = lib.mkIf config.terminal.utils.gitui.enable {
    environment.systemPackages = [
      pkgs.gitui
    ];
  };
}

