# Full terminal config:
{config, lib, pkgs, inputs, ... }:
{
  imports = [
    ./alacritty.nix
    ./direnv.nix
    ./fastfetch.nix
    ./git.nix
    ./http-client.nix
    ./kitty.nix
    ./nushell.nix
    ./starship.nix
    ./wezterm.nix
    ./yazi.nix
    #./warp.nix
    ./zsh.nix
    ./zellij.nix
  ];
}
