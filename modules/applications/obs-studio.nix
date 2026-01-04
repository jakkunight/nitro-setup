_: let
  moduleName = "applications/obs-studio";
in {
  flake.modules = {
    nixos.${moduleName} = _: {
      programs.obs-studio.enableVirtualCamera = true;
    };
    nixos."${moduleName}/nvidia" = _: {
      programs.obs-studio = {
        enableVirtualCamera = true;
      };
    };
    homeManager.${moduleName} = {pkgs, ...}: {
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-pipewire-audio-capture
          obs-gstreamer
          obs-vkcapture
          droidcam-obs
          obs-multi-rtmp
          obs-source-record
        ];
      };
    };
  };
}
