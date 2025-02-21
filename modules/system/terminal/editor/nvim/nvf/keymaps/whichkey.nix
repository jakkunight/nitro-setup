{ lib, config, ... }:
{
  config = {
    programs.nvf.settings.vim = {
      binds.whichKey = {
        enable = true;
      };
    };
  };
}
