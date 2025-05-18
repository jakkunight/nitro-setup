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
      completion = {
        enable = true;
      };
    };
    keymaps = [
      {
        key = "<Tab>";
        mode = ["i"];
        action = "pumvisible() ? \"\\<C-n>\" : \"\\<Tab>\"";
        expr = true;
      }
      {
        key = "<S-Tab>";
        mode = ["i"];
        action = "pumvisible() ? \"\\<C-p>\" : \"\"";
        expr = true;
      }
      {
        key = "<CR>";
        mode = ["i"];
        action = "pumvisible() ? \"\\<C-y>\" : \"\\<CR>\"";
        expr = true;
      }
    ];
  };
}
