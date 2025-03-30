{ lib, config, inputs, ... }:
{
  config = {
    programs.nvf.settings.vim = {
      mini = {
        starter = {
          enable = true;
        };
      };
    };
  };
}
