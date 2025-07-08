{pkgs, ...}: {
  programs.mangohud = {
    enable = true;
  };

  home.packages = with pkgs; [
    wineWowPackages.stable
    winetricks
    wineWayland
    steam
    heroic
    bottles-unwrapped
    discord
  ];
}
