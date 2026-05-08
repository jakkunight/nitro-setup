let
  feature = "multimedia";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          mpv
          ffmpeg # Used to play my music and videos ad hoc.
          vlc
        ];
      };
    homeManager.${feature} =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          mpv
          ffmpeg # Used to play my music and videos ad hoc.
          vlc
        ];
      };
  };
}
