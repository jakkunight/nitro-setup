# Manage package installed systemwide:
{ config, lib, pkgs, ... }@inputs: {
  # List packages installed in system profile. To search, run:
  # nix search <package_name>

  # Allow Unfree Software:
  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = with pkgs; [
    git # Version Control system.
    neovim # Main text editor
    micro # Main text editor (for simple edits)
    nix-ld # Linker for NixOS
    yazi # Main filemanager (for the terminal)
    zellij # Main terminal multiplexer
    tmux # Secondary terminal multiplexer
    vim # Base text editor
    wget # Utility to download files from the web
    btop # A great tool for monitoring processes
    htop # The classic HTOP to monitor processes
    neofetch # A CLI system info display
    waybar # The bar for Wayland compositors (Hyprland in this case)
    wofi # The app launcher for Wayland compositors (Hyprland in this case)
    alacritty # My Main GPU powered terminal emulator
    swww # A program to set the wallpaper on Wayland
    dbus # The most popular intercommunication process tool.
    gvfs # A service to autodetect USB drives.
    udisks2 # A tool to manage USB devices.
    udiskie # A tool for automounting USB drives.
    usbutils # Utilities for USB mangement.
    # To setup IPSec connections:
    strongswan
    networkmanager_strongswan
    # Development tools:
    python312
    nodejs
    rustup
    go
    php
    gcc
    cmake
    ninja
    bison
    meson
    premake
    lua
  ];
}
