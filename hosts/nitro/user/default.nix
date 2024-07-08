# Default user config for HomeManager:
{ config, lib, pkgs, ... }@inputs:
{
  imports = [
    ./alacritty.nix
    ./hyprland.nix
    ./zsh.nix
    ./nvim.nix
  ];
}
