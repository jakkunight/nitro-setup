{ pkgs, lib, config, ... }@inputs:
{
  imports = [
    ./tlp.nix
    ./usb.nix
    ./flatpak.nix
    ./printing.nix
    ./virtualization.nix
  ];
}
