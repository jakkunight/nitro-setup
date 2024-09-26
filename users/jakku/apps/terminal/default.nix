# Full terminal config:
{config, lib, pkgs, inputs, ... }:
{
  imports = [
    ./alacritty.nix
    ./direnv.nix
    ./fastfetch.nix
    ./git.nix
    ./slumber.nix
    ./nushell.nix
    ./starship.nix
    ./wezterm.nix
    ./yazi.nix
    #./warp.nix
    ./zsh.nix
    ./zellij.nix
  ];
}
