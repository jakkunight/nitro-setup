{ lib, config, inputs, ... }:
{
  config = {
    programs.nvf.settings.vim = {
      mini = {
        notify = {
          enable = true;
        };
      };
    };
  };
}

