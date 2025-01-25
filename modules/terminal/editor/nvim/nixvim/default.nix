# N config:
{ lib, config, inputs, ... }: {
  imports = [];
  options = {
    terminal.editor.nvim.nixvim = {
      enable = lib.mkEnableOption "Use NixVim as your Neovim flavor.";
    };
  };
  config = lib.mkIf config.terminal.editor.nvim.nixvim.enable {};
}
