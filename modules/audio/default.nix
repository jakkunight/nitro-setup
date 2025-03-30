# Sound module bundle:
{ lib, config, ... }: {
  imports = [
    ./pipewire.nix
    ./pulseaudio.nix
    ./mpd.nix
  ];
  options = {
    audio = {
      enable = lib.mkEnableOption "Enable the sound system.";    };
  };
  config = lib.mkIf config.audio.enable {
    audio = {
      pulseaudio.enable = lib.mkDefault false;
      pipewire.enable = lib.mkDefault true;
    };
  };
}
