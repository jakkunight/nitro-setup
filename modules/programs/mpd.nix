let
  feature = "mpd";
in
{
  flake.modules = {
    homeManager.${feature} =
      {
        config,
        pkgs,
        ...
      }:
      {
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
        services.playerctld = {
          enable = true;
        };
        services.mpdris2 = {
          enable = true;
          mpd = {
            host = "127.0.0.1";
            port = 6600;
          };
          multimediaKeys = true;
          notifications = true;
        };
        services.mpris-proxy.enable = true;
        home.packages = with pkgs; [
          mpd
          mpdris2
        ];
      };
  };
}
