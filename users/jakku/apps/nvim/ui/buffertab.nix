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
      	action = "<cmd>bd<CR>";
	key = "<leader>bd";
	mode = "n";
      }
      {
      	action = "<cmd>bn<CR>";
	key = "<leader>bn";
	mode = "n";
      }
      {
      	action = "<cmd>bp<CR>";
	key = "<leader>bp";
	mode = "n";
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
