# Default user config for HomeManager:
{ config, lib, pkgs, ... }@inputs:
{
  imports = [
    ./alacritty.nix
    #./hyprland.nix
    ./zsh.nix
    ./git.nix
    ./nvim.nix
  ];
}
