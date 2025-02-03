{ lib, config, inputs, ... }:
{
  config = {
    programs.nvf.settings.vim = {
      mini = {
        statusline = {
          enable = true;
        };
      };
    };
  };
}
