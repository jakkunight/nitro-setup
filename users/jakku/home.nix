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
    VISUAL = "nvim";
  };

  # Allow unfree software:
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Import the configs:
  imports = [
    ./apps/nvim
    ./apps/office
    ./apps/theming
    ./apps/hyprland
    ./apps/terminal
    ./apps/multimedia
    ./apps/vscode
    ./apps/web-browsers
    ./apps/android
    ./apps/zed
  ];
}
