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
      	action = "<cmd>Neotree toggle<CR>";
	key = "<leader>e";
	mode = "n";
      }
    ];
  };
}
