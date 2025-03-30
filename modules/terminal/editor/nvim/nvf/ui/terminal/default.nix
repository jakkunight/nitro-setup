{ config, lib, ... }:
{
  config = {
    programs.nvf.settings.vim = {
      terminal = {
        toggleterm = {
          enable = true;
          mappings = {
            open = "<leader>to";
          };
        };
      };
    };
  };
}
