{
  programs.nixvim = {
    plugins.lspsaga = {
      enable = true;
      lightbulb = {
        enable = true;
        sign = false;
      };
    };
    keymaps = [
      {
        action = "<cmd>Lspsaga code_action<CR>";
        key = "<leader>ca";
        options = {
          desc = "LSP Code Actions";
        };
      }
      {
        action = "<cmd>Lspsaga rename<CR>";
        key = "<leader>cr";
        options = {
          desc = "LSP Rename";
        };
      }
    ];
  };
}
