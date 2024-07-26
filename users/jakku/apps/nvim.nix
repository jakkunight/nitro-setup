# Neovim config:
{ config, lib, pkgs, ... }:
let
  toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  toLua = line: "lua << EOF\n${line}\nEOF\n";
in
{
  programs.nixvim = {
    enable = true;
    # Global options:
    opts = {
      number = true;
      shiftwidth = 2;
      smartindent = true;
      softtabstop = 2;
      showtabline = 2;
      expandtab = true;
      breakindent = true;
      mouse = "a";
      cursorline = true;
      encoding = "utf-8";
      fileencoding = "utf-8";
    };
    globals.mapleader = " ";
    # Global keymaps:
    keymaps = [];
    # Use TokyoNight colorscheme:
    colorschemes.tokyonight = {
      enable = true;
      settings = {
        style = "night";
      };
    };
    # Plugins:
    plugins = {
      # Use Lualine:
      lualine = {
        enable = true;
	#settings = {};
      };
      # Use Bufferline:
      bufferline = {
        enable = true;
      };
      # Use indent blank-line:
      indent-blankline = {
        enable = true;
      };
      # Enable Telescope:
      telescope = {
        enable = true;
      };
      # Enable Neotree:
      neo-tree = {
        enable = true;
      };
      # Enable Which-key:
      which-key = {
        enable = true;
      };
      # Use Lazygit:
      lazygit = {
        enable = true;
      };
    };
  };
}
