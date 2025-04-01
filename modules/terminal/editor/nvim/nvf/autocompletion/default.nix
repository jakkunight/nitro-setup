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
        snippets = {
          enable = true;
        };
      };
      autocomplete = {
        # nvim-cmp = {
        #   enable = true;
        #   sourcePlugins = [
        #     "cmp-buffer"
        #     "cmp-path"
        #     "cmp-nvim-lsp"
        #     "cmp-treesitter"
        #     "lspsaga-nvim"
        #     "lspkind-nvim"
        #     "cmp-luasnip"
        #     "none-ls-nvim"
        #     "rustaceanvim"
        #     "todo-comments-nvim"
        #     "sqls-nvim"
        #     "none-ls-nvim"
        #     pkgs.markdown-oxide
        #   ];
        # };
        blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;
          # sourcePlugins = {
          #   spell = {
          #     package = "";
          #   };
          # };
        };
      };
    };
  };
}
