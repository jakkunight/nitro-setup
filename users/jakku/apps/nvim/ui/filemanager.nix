{
  programs.nixvim = {
    plugins.neo-tree = {
      enable = true;
      enableDiagnostics = true;
      enableGitStatus = true;
      enableRefreshOnWrite = true;
      filesystem.filteredItems.visible = true;
    };
    keymaps = [
      {
      	action = "<cmd>Neotree focus<CR>";
	key = "<leader>y";
	mode = "n";
	options = {
	  desc = "Focus Neotree";
	};
      }
      {
      	action = "<cmd>Neotree toggle<CR>";
	key = "<leader>e";
	mode = "n";
	options = {
	  desc = "Toggle Neotree";
	};
      }
    ];
  };
}
