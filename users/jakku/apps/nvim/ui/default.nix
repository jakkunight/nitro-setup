{
  programs.nixvim.plugins = {
    web-devicons.enable = true;
    nvim-surround = {
      enable = true;
    };
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
