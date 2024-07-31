# Config module for Neovim/Nixvim:
{ config, lib, pkgs, ... }@inputs:
{
  imports = [
    ./ui/filefinder.nix
    ./ui/statusline.nix
    ./ui/buffertab.nix
    ./ui/filemanager.nix
    ./ui/whichkey.nix
    ./ui/dashboard.nix
    ./syntax-highlighting
    ./autocompletions
    ./lsp
  ];
  programs.nixvim = {
    enable = true;
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
}
