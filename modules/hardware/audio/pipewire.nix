{inputs, ...}: {
  flake.modules.nixos."hardware/audio/pipewire" = {pkgs, ...}: {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      audio.enable = true;
      wireplumber = {
        enable = true;
        package = pkgs.wireplumber;
      };
      pulse.enable = true;
      jack.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };
    environment.systemPackages = with pkgs; [
      pavucontrol
      helvum
      bluez5
    ];
  };
}
