# ¿Gaming packages? config.
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    steam
    lutris
    wineWowPackages.stable
    winetricks
    playonlinux
    tokyonight-gtk-theme
  ];
}
