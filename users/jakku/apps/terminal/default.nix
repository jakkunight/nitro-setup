# Full terminal config:
{config, lib, pkgs, ...}@inputs:
{
  imports = [
    ./alacritty.nix
    ./git.nix
    ./yazi.nix
    ./zsh.nix
    ./zellij.nix
  ];
}
