# Developmant utilities:
{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nix-ld
    envfs
    cachix
    devenv
    devbox
    direnv
    rustup
    cargo
    cargo-binstall
    cargo-binutils
    python312Full
    gcc
    gnustep.stdenv
    gnumake
    cmake
    clang
  ];
}
