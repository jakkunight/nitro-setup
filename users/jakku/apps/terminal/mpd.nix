{ config, lib, pkgs, ... }:
{
  config =
  let
    username = "jakku";
    userDir = "/home/jakku";
  in
  {
    services.mpd = {
      enable = true;
      musicDirectory = "${userDir}/Music";
      user = "${username}";
      extraConfig = ''
        # must specify one or more outputs in order to play audio!
        # (e.g. ALSA, PulseAudio, PipeWire), see next sections
        # PipeWire:
        audio_output {
          type "pipewire"
          name "My PipeWire Output"
        }
      '';

      # Optional:
      network = {
        listenAddress = "any"; # if you want to allow non-localhost connections
        startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
      };
    };
    systemd.services.mpd.environment = {
      XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.userRunningPipeWire.uid}"; # User-id must match above user. MPD will look inside this directory for the PipeWire socket.
    };
  };
}
