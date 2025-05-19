_: {
  programs.nvf.settings.vim = {
    mini = {
      bracketed = {
        enable = true;
      };
      comment = {
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
      surround = {
        enable = true;
      };
    };
    autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
      setupOpts = {
        completion = {
          accept.auto_brackets.enable = true;
          ghost_text.enable = true;
        };
        sources = {
          default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
            "ripgrep"
            "spell"
          ];
          providers = {
            ripgrep = {
              module = "blink-ripgrep";
            };
            spell = {
              module = "blink-cmp-spell";
            };
          };
        };
        snippets = {
          presets = "mini_snippets";
        };
      };
      sourcePlugins = {
        ripgrep = {
          enable = true;
          module = "blink-ripgrep";
          package = "blink-ripgrep-nvim";
        };
        spell = {
          enable = true;
          module = "blink-cmp-spell";
          package = "blink-cmp-spell";
        };
      };
    };
  };
}
