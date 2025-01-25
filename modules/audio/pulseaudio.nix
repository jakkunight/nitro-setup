# PulseAudio Config:
{ lib, config, ... }: {
  options = {
    audio = {
      pulseaudio = {
        enable = lib.mkEnableOption "Enable PulseAudio";
      };
    };
  };
  config = lib.mkIf (config.audio.pulseaudio.enable) {
    # Disable PipeWire explicitly:
    services.pipewire.enable = false;
    
    # Config PulseAudio:
    services.pulseaudio = {
      enable = true;
      support32Bit = true;
    };
  };
}
