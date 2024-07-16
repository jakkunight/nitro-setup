# Utilities to manage compressed files:
{ pkgs }:
{
  environment.systemPackages = with pkgs; [
    rar
    zip
    unzip
    gzip
    xz
    lz4
    gnutar
    p7zip
  ];
}
