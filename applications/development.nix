# Developmant utilities:
{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nix-ld
    envfs
    cachix
    devenv
    devbox
    rustup
    cargo
    bun
    nodejs
    cmake
    gnumake
    gcc
    stdenv
    clang
    turso-cli
    sqlite
    mysql84
    postgresql_16
    mariadb_110
    webkitgtk
    librsvg
    cairo
    gdk-pixbuf
    openssl_3
    libsoup
    pkg-config
    appimagekit
  ];
}
