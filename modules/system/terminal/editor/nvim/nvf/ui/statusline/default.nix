{ lib, config, inputs, ... }:
{
  config = {
    programs.nvf.settings.vim = {
      statusline.lualine = {
        enable = true;
      };
    };
  };
}
