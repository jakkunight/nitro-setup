{
  programs.nixvim = {
    plugins = {
      web-devicons.enable = true;
      nvim-surround = {
        enable = true;
      };
    };
    keymaps = [
      {
        action = "<cmd>Lspsaga code_action<CR>";
        key = "<leader>ca";
        options = {
          desc = "LSP Code Actions";
        };
      }
    ];
  };
  imports = [
    ./git.nix
    ./terminal.nix
    ./whichkey.nix
    ./buffertab.nix
    ./filefinder.nix
    ./dashboard.nix
    ./statusline.nix
    ./filemanager.nix
  ];
}
