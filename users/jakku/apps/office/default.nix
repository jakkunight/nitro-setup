# Office and work apps:
{config, pkgs, lib, ...}@inputs:
{
  home.packages = with pkgs; [
    # Nchat, to chat from the terminal:
    nchat
    # Discord, for chatting:
    discord
    # RDP/VNC client:
    remmina
    # Email client:
    thunderbird
    # Office:
    libreoffice
    # LaTeX:
    pandoc
    texliveFull
    rubber
  ];
  imports = [
    ./remmina.nix
    ./zathura.nix
  ];
}
