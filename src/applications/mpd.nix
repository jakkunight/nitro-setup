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
        home.packages = with pkgs; [
          mpd
        ];
      };
  };
}
