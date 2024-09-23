# Full terminal config:
{config, lib, pkgs, ...}@inputs:
{
  imports = [
    ./alacritty.nix
    ./direnv.nix
    ./git.nix
    ./nushell.nix
    ./yazi.nix
    #./warp.nix
    ./zsh.nix
    ./zellij.nix
  ];
}
