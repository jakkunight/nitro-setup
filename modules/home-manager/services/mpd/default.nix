{
  pkgs,
  config,
  ...
}: {
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    playlistDirectory = "${config.home.homeDirectory}/Music/Playlists";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
    '';
  };

  home.packages = with pkgs; [
    mpd
    mpv
    puddletag
    yt-dlp
    ffmpeg
    matugen
  ];

  home.sessionVariables = {
    MPD_HOST = "/run/user/1000/mpd/socket";
  };

  programs.rmpc = {
    enable = true;
    package = pkgs.rmpc;
    config = ''
      (
        address: "/run/user/1000/mpd/socket",
        cache_dir: Some("/home/jakku/.cache/rmpc"),
      )
    '';
  };
}
