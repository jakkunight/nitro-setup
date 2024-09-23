# Full terminal config:
{config, lib, pkgs, ...}@inputs:
{
  imports = [
    ./alacritty.nix
    ./direnv.nix
    ./fastfetch.nix
    ./git.nix
    ./nushell.nix
    ./starship.nix
    ./yazi.nix
    #./warp.nix
    ./zsh.nix
    ./zellij.nix
  ];
}
