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
  ];
  boot.extraModprobeConfig = ''
    options snd-hda-intel model=auto
  '';
}
