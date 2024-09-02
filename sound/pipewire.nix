# Audio config. Using PipeWire instead of PulseAudio.
{ config, lib, pkgs, inputs, ... }:
{
  # Disable PulseAudio explicitly:
  hardware.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;

    # Redirects PulseAudio calls to PipeWire:
    pulse.enable = true;

    # Enable ALSA devices:
    alsa = {
      enable = true;
      support32Bit = true;
    };

    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  
  environment.systemPackages = with pkgs; [
    # Use Helvum and QPWGraph to config PipeWire:
    qpwgraph
    helvum

    # Use ALSA utils:
    alsa-utils
    alsa-plugins
    alsa-lib
  ];
}
