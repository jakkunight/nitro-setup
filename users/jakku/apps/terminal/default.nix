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
    ./mpd.nix
    ./nushell.nix
    ./starship.nix
    ./yazi.nix
    ./zsh.nix
    ./zellij.nix
  ];
}
