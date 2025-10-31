{pkgs, ...}: {
  programs.mangohud = {
    enable = true;
  };

  home.packages = with pkgs; [
    wineWow64Packages.stable
    winetricks
    wine-wayland
    heroic
    bottles-unwrapped
    discord
    (import ./install-capture-age.nix {inherit pkgs;})
    (import ./run-capture-age.nix {inherit pkgs;})
  ];
}
