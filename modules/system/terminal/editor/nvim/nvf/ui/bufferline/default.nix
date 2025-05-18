_: {
  programs.nvf.settings.vim = {
    mini.tabline = {
      enable = true;
    };
    keymaps = [
      {
        key = "<leader>-";
        action = ":bd!<CR>";
        mode = ["n"];
        desc = "Close current buffer.";
      }
      {
        key = "<leader>.";
        action = ":bn<CR>";
        mode = ["n"];
        desc = "Cycle next buffer.";
      }
      {
        key = "<leader>,";
        action = ":bp<CR>";
        mode = ["n"];
        desc = "Cycle prev buffer.";
      }
    ];
  };
}
