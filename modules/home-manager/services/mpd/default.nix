{pkgs, ...}: {
  services.mpd = {
    enable = true;
    musicDirectory = "/home/jakku/Music";
    network.startWhenNeeded = pkgs.stdenv.hostPlatform.system == "x86_64-linux";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
    '';
  };

  home.packages = with pkgs; [
    mpd
    mpv
    puddletag
  ];

  home.sessionVariables = {
    MPD_HOST = "run/user/1000/mpd/socket";
  };

  programs.rmpc = {
    enable = true;
    package = pkgs.rmpc;
    # config = '''';
  };
}
