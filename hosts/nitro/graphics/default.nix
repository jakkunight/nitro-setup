{ pkgs, lib, config, ... }@inputs:
{
  imports = [
    ./x11.nix
    ./sddm.nix
    ./fonts.nix
    ./hyprland.nix
    ./nvidia-drivers.nix
  ];
}
