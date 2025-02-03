{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;
    };
    keymaps = [
      {
	action = "<cmd>Telescope find_files<CR>";
	key = "<leader>ff";
	mode = "n";
	options = {
	  desc = "Find file with Telescope";
	};
      }
      {
	action = "<cmd>Telescope buffers<CR>";
	key = "<leader>fb";
	mode = "n";
	options = {
	  desc = "Find buffers with Telescope";
	};
      }
      {
	action = "<cmd>Telescope live_grep<CR>";
	key = "<leader>fg";
	mode = "n";
	options = {
	  desc = "Perform a live grep with Telescope";
	};
      }
    ];
  };
}
