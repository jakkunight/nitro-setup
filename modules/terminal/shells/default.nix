# Shell configuration:
{ lib, config, ... }: {
  imports = [
    ./zsh.nix
  ];
  options = {
    terminal.shells = {
      enable = lib.mkEnableOption "Enable custom shell configurations";
    };
  };
  config = lib.mkIf config.terminal.shells.enable {
    terminal = {
      shells = {
        zsh = {
          enable = lib.mkDefault true;
          default = lib.mkDefault true;
        };
      };
    };
  };
}
