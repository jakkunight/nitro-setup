# OBS Studio setup:
{ pkgs, lib, config, ... }@inputs:
{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs; [
      # Straming and screen recording:
      obs-studio-plugins.obs-gstreamer
      obs-studio-plugins.obs-multi-rtmp
    ];
  };
}
