{ config, lib, inputs, ... }:
{
  options = {};
  config = {
    programs.nvf.settings.vim = {
      filetree = {
        neo-tree = {
          enable = true;
          setupOpts = {
            git_status_async = true;
          };
        };
      };
    };
  };
}
