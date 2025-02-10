{ lib, config, inputs, pkgs, ... }:
{
  imports = [
    ./notifications
    ./statusline
    ./dashboard
    ./bufferline
    ./filetree
  ];
  config = {
    programs.nvf.settings.vim = {
      theme = {
        enable = true;
        name = "tokyonight";
        style = "night";
      };

      mini = {
        icons = {
          enable = true;
        };
        indentscope = {
          enable = true;
        };
        trailspace = {
          enable = true;
        };
        hipatterns = {
          enable = true;
        };
      };
    };
  };
}
