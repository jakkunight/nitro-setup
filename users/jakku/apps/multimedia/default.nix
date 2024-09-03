# Multimedia user packages:
{config, lib, pkgs, ...}@inputs:
{
  home.packages = with pkgs; [
    # Commons:
    mpd
    ffmpeg
    playerctl
    # Music players:
    moc
    # Video players:
    vlc
    # Image viewers:
    loupe
    # Straming and screen recording:
    obs-studio
    # Drawing:
    krita
    # Music production:
    lmms
    audacity
    # Video edition:
    libsForQt5.kdenlive
    # Youtube:
    youtube-tui
    # Manga Reader:
    mangal
    manga-cli
    mangareader
  ];

  imports = [
    ./playerctl.nix
  ];
}
