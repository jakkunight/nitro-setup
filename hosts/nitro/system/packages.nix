# Manage package installed systemwide:
{ config, lib, pkgs, ... }@inputs: {
  # List packages installed in system profile. To search, run:
  # nix search <package_name>

  # Allow Unfree Software:
  nixpkgs.config.allowUnfree = true;

  # Set ZSH as default shell:
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    git # Version Control system.
    busybox # Coreutils for every GNU/Linux distro.
    gawk # awk command
    home-manager # Home-Manager!
    ripgrep # GREP, rewritten in Rust
    gnugrep # The classic GREP utility
    #neovim # Main text editor
    micro # Main text editor (for simple edits)
    nix-ld # Linker for NixOS
    mdr # Utility for rendering Markdown files on the terminal
    texliveFull # The LaTeX toolkit.
    rubber # Live LaTeX compiler.
    pandoc # A tool to compile Markdown to PDF
    yazi # Main filemanager (for the terminal)
    zellij # Main terminal multiplexer
    fzf # FuzzyFinder
    tmux # Secondary terminal multiplexer
    vim # Base text editor
    wget # Utility to download files from the web
    btop # A great tool for monitoring processes
    htop # The classic HTOP to monitor processes
    fastfetch # A CLI system info display
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
    networkmanagerapplet # To manage networking.
    glib # The GNU Standard C Library.
    vlc
    #gnome.networkmanager-l2tp
    # To manage compressed files:
    zip
    unzip
    gzip
    busybox
    xz
    rar
    lz4
    # To setup IPSec connections:
    strongswan
    strongswanNM
    networkmanager_strongswan
    #networkmanager-l2tp
    #xl2tpd
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
    # Virtualization:
    qemu
    quickemu
    # Gaming:
    wineWowPackages.stable
    winetricks
    wineWowPackages.waylandFull
    # Themes:
    tokyonight-gtk-theme
  ];
}
