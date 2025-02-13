{ config, lib, pkgs, inputs, ... }:
{
  options = {};
  config = {
    programs.nvf.settings.vim = {
      telescope = {
        enable = true;
      };
    };
  };
}
