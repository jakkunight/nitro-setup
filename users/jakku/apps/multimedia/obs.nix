# OBS Studio setup:
{ pkgs, lib, config, ... }@inputs:
{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs; [
      # Straming and screen recording:
      obs-studio-plugins.wlrobs
      obs-studio-plugins.obs-vkcapture
      obs-studio-plugins.obs-gstreamer
      obs-studio-plugins.obs-multi-rtmp
      obs-studio-plugins.obs-mute-filter
      obs-studio-plugins.obs-pipewire-audio-capture
    ];
  };
}
