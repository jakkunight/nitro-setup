{ lib, config, inputs, ... }:
{
  config = {
    programs.nvf.settings.vim = {
      tabline.nvimBufferline = {
        enable = true;
        mappings = {
          closeCurrent = "<leader>bx";
        };
      };
    };
  };
}
