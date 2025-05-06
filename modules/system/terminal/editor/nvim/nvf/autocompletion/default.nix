_: {
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

    lsp.lspkind = {
      enable = true;
    };

    autocomplete = {
      enableSharedCmpSources = true;
      blink-cmp = {
        enable = true;
        friendly-snippets.enable = true;
        setupOpts = {
          auto_show = true;
          sources = {
            default = [
              "lsp"
              "path"
              "snippets"
              "buffer"
              "omni"
              "spell"
              "ripgrep"
            ];
          };
          providers = {
            lsp = {
              enable = true;
              module = "";
              score_offset = 100;
            };
            path = {
              enable = true;
              score_offset = 200;
            };
            snippets = {
              enable = true;
              score_offset = 300;
            };
            buffer = {
              enable = true;
              score_offset = 400;
            };
            omni = {
              enable = true;
              score_offset = 600;
            };
          };
        };
        sourcePlugins = {
          ripgrep = {
            enable = true;
            package = "blink-ripgrep-nvim";
          };
          spell = {
            enable = true;
            package = "blink-cmp-spell";
          };
        };
      };
    };
  };
}
