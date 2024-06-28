# Manage package installed systemwide:
{ config, lib, pkgs, ... }@inputs: {
  # List packages installed in system profile. To search, run:
  # nix search <package_name>
  environment.systemPackages = with pkgs; [
    git
    neovim
    micro
    yazi
    zellij
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
  ];
}
