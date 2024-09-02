# ALSA audio settings:
{ config, lib, pkgs, ... }@inputs: {
  # Save ALSAmixer settings:
  sound.enable = true;
  security.rtkit.enable = true;

  # ALSA firmware:
  hardware.firmware = with pkgs; [
    sof-firmware
    alsa-firmware
  ];
  # Make your audio card the default ALSA card:
  boot.extraModprobeConfig = ''
    options snd slots=sof-audio-pci-intel-tgl
    options snd slots=snd-hda-intel
  '';

  # ALSA packages:
  environment.systemPackages = with pkgs; [
    sof-firmware
    alsa-firmware 
    alsa-topology-conf
    alsa-ucm-conf
    alsa-utils
  ];
}
