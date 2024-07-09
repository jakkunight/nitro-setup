# Basic shell.nix
{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell
{
  # ...
  nativeBuildInputs = with pkgs; [
    # Packages
  ];
  shellHook = ''
    neofetch
    echo "[^o^] Welcome back Coder!"
    echo "[^-^] Everything is ready for your next Project!"
  '';
}
