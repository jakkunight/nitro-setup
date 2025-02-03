{ lib, config, inputs, ... }:
{
  config = {
    programs.nvf.settings.vim = {
      mini = {
        tabline = {
          enable = true;
        };
      };
    };
  };
}
