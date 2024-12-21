# Developmant utilities:
{ config, lib, pkgs, inputs, ... }:
{
  environment.systemPackages = [
    pkgs.nix-ld
    pkgs.cachix
    inputs.devenv-repo.packages."x86_64-linux".devenv
    # pkgs.devenv
    pkgs.direnv
    pkgs.cargo-binutils
    pkgs.gobang
    pkgs.httpie
    pkgs.httpie-desktop
    pkgs.bruno
    pkgs.dbeaver-bin
    pkgs.present
    pkgs.presenterm
    pkgs.neovim
    pkgs.firefox
  ];
}
