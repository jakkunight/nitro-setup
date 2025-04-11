{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
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
      };
      autocomplete = {
        blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;
        };
      };
    };
  };
}
