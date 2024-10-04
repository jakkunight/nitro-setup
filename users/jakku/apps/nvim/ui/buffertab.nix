{
  programs.nixvim = {
    plugins.bufferline = {
      enable = true;
      settings = {
	options = {
	  alwaysShowBufferline = true;
	};
      };
    };
    keymaps = [
      {
        action = "<cmd>enew<CR>";
        key = "<leader>b";
        mode = "n";
        options = {
          desc = "Create a new buffer";
        };
      }
      {
      	action = "<cmd>bd<CR>";
	key = "<leader>x";
	mode = "n";
	options = {
	  desc = "Delete current buffer";
	};
      }
      {
      	action = "<cmd>bn<CR>";
	key = "<leader>.";
	mode = "n";
	options = {
	  desc = "Focus next buffer";
	};
      }
      {
      	action = "<cmd>bp<CR>";
	key = "<leader>,";
	mode = "n";
	options = {
	  desc = "Focus previous buffer";
	};
      }
      {
      	action = "<cmd>w<CR>";
	key = "<C-s>";
	mode = "n";
      }
      {
      	action = "<cmd>q<CR>";
	key = "<C-q>";
	mode = "n";
      }
      {
      	action = "<cmd>qa<CR>";
	key = "<C-Q>";
	mode = "n";
      }
    ];
  };
}
