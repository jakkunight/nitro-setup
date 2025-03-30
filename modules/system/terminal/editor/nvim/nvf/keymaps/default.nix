{ lib, config, inputs, pkgs, ... }:
{
  imports = [
    ./whichkey.nix
  ];
  options = {};
  config = {
    programs.nvf.settings.vim = {
      keymaps = [
        {
          key = "<leader>tt";
          mode = [ "n" ];
          action = ":Neotree toggle<CR>";
          desc = "Toggles the filetree.";
        }
        {
          key = "<leader>tf";
          mode = [ "n" ];
          action = ":Neotree focus<CR>";
          desc = "Focus the filetree.";
        }
        {
          key = "<leader>tr";
          mode = [ "n" ];
          action = ":Neotree right<CR>";
          desc = "Set filetree to the right.";
        }
        {
          key = "<leader>tw";
          mode = [ "n" ];
          action = ":Neotree float<CR>";
          desc = "Set filetree to floating.";
        }
        {
          key = "<leader>tl";
          mode = [ "n" ];
          action = ":Neotree left<CR>";
          desc = "Set tree to the left.";
        }
      ];
    };
  };
}
