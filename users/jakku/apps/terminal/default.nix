# Full terminal config:
{config, lib, pkgs, ...}@inputs:
{
  imports = [
    ./alacritty.nix
    ./git.nix
    ./zsh.nix
  ];
}
