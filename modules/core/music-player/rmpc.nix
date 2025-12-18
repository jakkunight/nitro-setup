{inputs, ...}: {
  flake.modules.nixos."music-player/mpd" = _: {
  };
  flake.modules.homeManager."music-player/mpd" = {
    config,
    pkgs,
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
      network.startWhenNeeded = true;
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
  };
  flake.modules.homeManager."music-player/rmpc" = {
    pkgs,
    config,
    osConfig,
    ...
  }: {
    programs.rmpc = {
      enable = true;
      package = pkgs.rmpc;
      config = ''
        (
          address: "/run/user/${(
          if osConfig.users.users.${config.home.username}.uid == null
          then "1000"
          else osConfig.users.users.${config.home.username}.uid
        )}/mpd/socket",
          cache_dir: Some("${(config.home.homeDirectory or "/home/${config.home.username}")}.cache/rmpc"),
        )
      '';
    };
  };
}
