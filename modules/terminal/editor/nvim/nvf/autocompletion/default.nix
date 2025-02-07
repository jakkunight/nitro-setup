{ lib, config, inputs, pkgs, ... }:
{
  config = {
    programs.nvf.settings.vim = {
      mini = {
        bracketed = {
          enable = true;
        };
        comment = {
          enable = true;
        };
        indentscope = {
          enable = true;
        };
        operators = {
          enable = true;
        };
        pairs = {
          enable = true;
        };
        snippets = {
          enable = true;
        };
      };
      autocomplete = {
        nvim-cmp = {
          enable = true;
          sourcePlugins = [
            "cmp-buffer"
            "cmp-path"
            "lspsaga"
          ];
        };
      };
    };
  };
}
