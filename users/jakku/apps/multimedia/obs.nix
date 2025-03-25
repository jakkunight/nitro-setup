# OBS Studio setup:
{ pkgs, lib, config, inputs, ... }:
{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      # Straming and screen recording:
      obs-gstreamer
      obs-multi-rtmp
      wlrobs
      obs-vaapi
      obs-pipewire-audio-capture
      obs-ndi
      obs-nvfbc
    ];
  };
}
