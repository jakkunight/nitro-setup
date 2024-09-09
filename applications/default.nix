{ pkgs, lib, config, ... }@inputs:
{
  imports = [
    ./gaming.nix
    ./info-tools.nix
    ./development.nix
    ./virtualization.nix
    ./cybersecurity.nix
    ./system-management.nix
    ./compressed-files.nix
  ];
}
