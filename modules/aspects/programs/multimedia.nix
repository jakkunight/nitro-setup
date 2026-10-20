let
  feature = "multimedia";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          mpv
          ffmpeg # Used to play my music and videos ad hoc.
          vlc
        ];
      };
    homeManager =
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
