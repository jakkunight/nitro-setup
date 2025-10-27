{config, ...}: {
  services.mpd = {
    enable = false;
    musicDirectory = "/home/jakku/Music";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Headphones__sink"
      }
    '';
    user = "jakku";
    group = "@wheel";
  };
  systemd.services.mpd.environment = {
    # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
    XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.jakku.uid}"; # User-id must match above user. MPD will look inside this directory for the PipeWire socket.
  };
}
