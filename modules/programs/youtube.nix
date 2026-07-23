let
  feature = "youtube";
in
{
  flake.modules = {
    nixos.${feature} =
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
    homeManager.${feature} =
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
