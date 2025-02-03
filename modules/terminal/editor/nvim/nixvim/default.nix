# Config module for Neovim/Nixvim:
{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    inputs.nixvim.nixosModules.nixvim
    ./ui
    ./syntax-highlighting
    ./autocompletions
    ./lsp
  ];
  options = {
    terminal.editor.nvim.nixvim = {
      enable = lib.mkEnableOption "Enable NixVim.";
    };
  };
  config = {
    programs.nixvim = {
      enable = true;
      clipboard.providers = {
        wl-copy.enable = true;
        xclip.enable = true;
      };
      globals = {
        mapleader = " ";
      };
      opts = {
        number = true;
        relativenumber = false;
        shiftwidth = 2;
      };
      colorschemes.tokyonight = {
        enable = true;
        settings = {
          style = "night";
        };
      };
    };
  };
}
