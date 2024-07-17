# ¿Gaming packages? config.
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    steam
    lutris
    wineWowPackages.stable
    winetricks
    tokyonight-gtk-theme
    bottles
  ];
}
