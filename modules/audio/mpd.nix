{ lib, config, ... }: {
  options = {
    audio.mpd = {
      enable = lib.mkEnableOption "Enable the music player daemon service";
      user = lib.mkOption {
        type = lib.types.nonEmptyStr;
        default = "user";
      };
      pipewire = lib.mkEnableOption "Enable PipeWire backend.";
      pulseaudio = lib.mkEnableOption "Enable PulseAudio backend.";
    };
  config = lib.mkIf config.audio.mpd.enable {
  
    services.mpd.enable = true;
  } // (
        if config.audio.mpd.pipewire
        then {
          services.mpd.extraConfig = ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
    '';
    service.mpd.user = "${config.audio.mpd.user}";
    };
    systemd.services.mpd.environment = {
      XDG_RUNTIME_DIR = "/run/user/${toString config.users.users."${config.audio.mpd.user}".uid}";
    };
        }
                        else (
        if 
        then {

        }
        else {}
        ));
}
