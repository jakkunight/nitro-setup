# Vanilla Neovim configuration:
{ lib, config, pkgs, ... }: {
  imports = [];
  options = {
    terminal.editor.nvim.vanilla = {
      enable = lib.mkEnableOption "Enable the vanilla Neovim flavor.";
    };
  };
  config = lib.mkIf config.terminal.editor.nvim.vanilla.enable {
    environment.systemPackages = [
      pkgs.neovim
    ];
  };
}
