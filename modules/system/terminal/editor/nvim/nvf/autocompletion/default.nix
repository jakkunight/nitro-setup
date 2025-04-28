{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
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
      # blink-cmp = {
      #   enable = true;
      #   friendly-snippets.enable = true;
      #   setupOpts.signature.enabled = true;
      # };
      nvim-cmp = {
        enable = true;
      };
    };
  };
}
