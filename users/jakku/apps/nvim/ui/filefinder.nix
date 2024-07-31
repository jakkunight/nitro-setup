{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;
    };
    keymaps = [
      {
	action = "<cmd>Telescope find_files<CR>";
	key = "<leader>f";
	mode = "n";
      }
    ];
  };
}
