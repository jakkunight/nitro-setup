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
      # completion = {
      #   enable = true;
      # };
    };
    # keymaps = [
    #   {
    #     key = "<Tab>";
    #     mode = ["i"];
    #     action = "pumvisible() ? \"\\<C-n>\" : \"\\<Tab>\"";
    #     expr = true;
    #   }
    #   {
    #     key = "<S-Tab>";
    #     mode = ["i"];
    #     action = "pumvisible() ? \"\\<C-p>\" : \"\"";
    #     expr = true;
    #   }
    #   {
    #     key = "<CR>";
    #     mode = ["i"];
    #     action = "pumvisible() ? \"\\<C-y>\" : \"\\<CR>\"";
    #     expr = true;
    #   }
    # ];
    autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
      setupOpts = {
        completion = {
          accept.auto_brackets = true;
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
            "latex"
            "ctags"
          ];
          providers = {
            ripgrep = {
              module = "blink-ripgrep";
            };
            spell = {
              module = "blink-cmp-spell";
            };
            latex = {
              module = "blink-cmp-latex";
            };
            ctags = {
              module = "blink-cmp-ctags";
              fallback_for = [
                "lsp"
              ];
            };
          };
        };
        snippets = {
          presets = "mini_snippets";
        };
      };
      sourcePlugins = {
        path = {
          enable = true;
          package = "cmp-path";
        };
      };
    };
  };
}
