# Here goes the audio related config:
{ config, lib, pkgs, ... }@inputs: {
  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
}
