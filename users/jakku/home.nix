# Home-Manager config:
{ config, lib, pkgs, ... }@inputs: {
  # Initial info:
  home.username = "jakku";
  home.homeDirectory = "/home/jakku";

  # DO NOT EDIT THIS!!!
  home.stateVersion = "24.05";

  # Session variables:
  home.sessionVariables = {
    # EDITOR = "emacs";
    EDITOR = "nvim";
    VISUAL = "micro";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Import the configs:
  imports = [
    ./apps/git.nix
    ./apps/waybar.nix
    ./apps/hyprland.nix
    ./apps/zsh.nix
    ./apps/qt.nix
    ./apps/gtk.nix
    ./apps/nvim.nix
  ];
}
