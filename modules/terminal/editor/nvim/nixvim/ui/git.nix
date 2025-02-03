{ config, pkgs, lib, ... }@inputs:
{
  programs.nixvim = {
    plugins = {
      gitsigns.enable = true;
      lazygit = {
	enable = true;
      };
    };
    keymaps =  [
      {
	action = "<cmd>LazyGit<CR>";
	key = "<leader>gg";
	mode = "n";
	options = {
	  desc = "Open Lazygit";
	}; 
      }
    ];
  };
}
