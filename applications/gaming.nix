# ¿Gaming packages? config.
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
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

  programs = {
    gamescope = {
      enable = true;
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraPackages = with pkgs; [
        gamescope
      ];
      #gamescopeSession = true;
    };
  };
}
