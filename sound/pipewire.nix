# Audio config. Using PipeWire instead of PulseAudio.
{ config, lib, pkgs, inputs, ... }:
{
  # Disable PulseAudio explicitly:
  hardware.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;

    # Redirects PulseAudio calls to PipeWire:
    pulse.enable = true;
  };
}
