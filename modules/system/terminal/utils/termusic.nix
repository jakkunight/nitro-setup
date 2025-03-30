# Termusic, a music player for the terminal written in Rust!
{ lib, config, pkgs, ... }: {
  options = {
    terminal.utils.termusic = {
      enable = lib.mkEnableOption "Enable Termusic.";
    };
  };
  config = lib.mkIf config.terminal.utils.termusic.enable {
    environment.systemPackages = with pkgs.gst_all_1; [
      pkgs.mpv-unwrapped
      gstreamer
      gst-plugins-rs
      gst-libav
      gst-plugins-base
      gst-plugins-good
      gst-plugins-bad
      gst-plugins-ugly
      gst-vaapi
      pkgs.termusic
    ];
  };
}

