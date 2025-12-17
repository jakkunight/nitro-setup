{inputs, ...}: {
  # flake.modules.nixos."mpd" = _: {

  # };
  flake.modules.home."mpd" = {
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
  flake.modules.home."rmpc" = {
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
          address: "/run/user/${osConfig.users.users.${config.home.username}.uid}/mpd/socket",
          cache_dir: Some("${config.home.homeDirectory}.cache/rmpc"),
        )
      '';
    };
  };
}
