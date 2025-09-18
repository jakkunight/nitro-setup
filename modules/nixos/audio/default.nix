# Configure NixOS audio:
{pkgs, ...}: {
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    jack.enable = true;
  };
  environment.systemPackages = with pkgs; [
    pavucontrol
    alsa-firmware
    alsa-utils
    alsa-ucm-conf
    sof-firmware
  ];
  boot.extraModprobeConfig = ''
    options snd-hda-intel model=auto
    options snd_hda_intel enable=0,1
    options snd slots=snd-hda-intel
  '';
}
