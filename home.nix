{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jakku";
  home.homeDirectory = "/home/jakku";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.sessionVariables = {
    # EDITOR = "emacs";
    EDITOR = "nvim";
    VISUAL = "micro";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # NeoVim:
  programs.neovim = 
  let
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n"; 
  in
  {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = LazyVim;
        #config = toLuaFile ;
      }
    ];
    # Use the Nix package search engine to find
    # even more plugins : https://search.nixos.org/packages
  };
}
