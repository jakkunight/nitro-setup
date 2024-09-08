{
  programs.nixvim = {
    plugins = {
      toggleterm = {
	enable = true;
	settings = {
	  autochdir = true;
	  close_on_exit = true;
	  direction = "horizontal";
	};
      };
    };
    keymaps = [
      {
	action = "<cmd>ToggleTerm direction=horizontal<CR>";
	key = "<leader>th";
	mode = "n";
	options = {
	  desc = "Open a new terminal horizontally";
	};
      }
      {
	action = "<cmd>ToggleTerm direction=float<CR>";
	key = "<leader>tf";
	mode = "n";
	options = {
	  desc = "Open a new terminal floating";
	};
      }
      {
	action = "<cmd>ToggleTerm direction=vertical<CR>";
	key = "<leader>tv";
	mode = "n";
	options = {
	  desc = "Open a new terminal vertically";
	};
      }
    ];
  };
}
