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
          key = "<leader>e";
          mode = [ "n" ];
          action = ":Neotree toggle<CR>";
          desc = "Toggles the filetree.";
        }
        {
          key = "<leader>x";
          mode = [ "n" ];
          action = ":bd!<CR>";
          desc = "Close current buffer without saving changes.";
        }
        {
          key = "<leader>ee";
          mode = [ "n" ];
          action = ":Neotree focus<CR>";
          desc = "Focus the filetree.";
        }
      ];
    };
  };
}
