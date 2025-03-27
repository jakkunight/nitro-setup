{ config, pkgs, ... }:
{
  config = {
    programs.nvf.settings.vim = {
      notes.obsidian = {
        enable = true;
        setupOpts = {
          completion.nvim-cmp = true;
          daily_notes = {
            date_format = "%A-%d-%m-%Y";
            folder = "~/Documents/nvim-obsidian";
          };
        };
      };
    };
  };
}
