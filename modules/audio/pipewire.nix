# PipeWire configuration:
{ lib, config, ... }: {
  options = {
    audio = {
      pipewire = {
        enable = lib.mkEnableOption "Enable PipeWire";
      };
    };
  };
  config = lib.mkIf (config.audio.pipewire.enable) {
    # rtkit is optional but recommended
    security.rtkit.enable = true;

    # Disable PulseAudio explicitly:
    hardware.pulseaudio.enable = false;

    # Config PipeWire:
    services.pipewire = {
      enable = true; # if not already enabled
      alsa = {
        enable = true;
        support32Bit = true;
      };

      # Redirect PulseAudio applications to use PipeWire:
      pulse.enable = true;

      # Redirect JACK applications to use PipeWire:
      jack.enable = true;

      # Enable and config Wireplumber:
      wireplumber = {
        enable = true;
      };
    };
  };
}

