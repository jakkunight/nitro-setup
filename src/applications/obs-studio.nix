let
  feature = "obs-studio";
in
{
  flake.modules.nixos.${feature} =
    { pkgs, ... }:
    {
      programs.obs-studio = {
        enable = true;
        enableVirtualCamera = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          droidcam-obs
          obs-gstreamer
          obs-multi-rtmp
          obs-pipewire-audio-capture
          obs-plugin-countdown
          obs-vkcapture
          obs-composite-blur
          obs-pipewire-audio-capture
          obs-source-record
        ];
      };
    };
  flake.modules.homeManager.${feature} =
    { pkgs, ... }:
    {
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          droidcam-obs
          obs-gstreamer
          obs-multi-rtmp
          obs-pipewire-audio-capture
          obs-plugin-countdown
          obs-vkcapture
          obs-composite-blur
          obs-pipewire-audio-capture
          obs-source-record
        ];
      };
    };
  flake.modules.nixos."${feature}-nvidia" =
    { pkgs, ... }:
    {
      programs.obs-studio = {
        enable = true;
        package = (
          pkgs.obs-studio.override {
            cudaSupport = true;
          }
        );
        enableVirtualCamera = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          droidcam-obs
          obs-gstreamer
          obs-multi-rtmp
          obs-pipewire-audio-capture
          obs-plugin-countdown
          obs-vkcapture
          obs-composite-blur
          obs-pipewire-audio-capture
          obs-source-record
        ];
      };

    };
  flake.modules.homeManager."${feature}-nvidia" =
    { pkgs, ... }:
    {
      programs.obs-studio = {
        enable = true;
        package = (
          pkgs.obs-studio.override {
            cudaSupport = true;
          }
        );
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          droidcam-obs
          obs-gstreamer
          obs-multi-rtmp
          obs-pipewire-audio-capture
          obs-plugin-countdown
          obs-vkcapture
          obs-composite-blur
          obs-pipewire-audio-capture
          obs-source-record
        ];
      };
    };
}
