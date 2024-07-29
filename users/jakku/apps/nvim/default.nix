# Config module for Neovim/Nixvim:
{ config, lib, pkgs, ... }@inputs:
{
  programs.nixvim = {
    enable = true;
    imports = [
      ./ui/filefinder.nix
      ./ui/statusline.nix
      ./ui/buffertab.nix
      ./ui/filemanager.nix
    ];
  };
}
