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
          obs-obs-vkcapture
        ];
      };
    };
  flake.modules.homeManager.${feature} =
    { pkgs, ... }:
    {
      home.programs.obs-studio = {
        enable = true;
        enableVirtualCamera = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          droidcam-obs
          obs-gstreamer
          obs-multi-rtmp
          obs-pipewire-audio-capture
          obs-plugin-countdown
          obs-obs-vkcapture
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
          obs-obs-vkcapture
        ];
      };

    };
  flake.modules.homeManager."${feature}-nvidia" =
    { pkgs, ... }:
    {
      home.programs.obs-studio = {
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
          obs-obs-vkcapture
        ];
      };
    };
}
