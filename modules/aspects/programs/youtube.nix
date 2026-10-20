let
  feature = "youtube";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          yt-dlp
          youtube-tui
          ytmdl
          ytfzf
          ytermusic
        ];
      };
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          yt-dlp
          youtube-tui
          ytmdl
          ytfzf
          ytermusic
        ];
      };
  };

}
