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
    mpg123
    libmpg123
  ];

  # Open GameRanger ports:
  networking.firewall.allowedUDPPorts = [
    16000
  ];
}
