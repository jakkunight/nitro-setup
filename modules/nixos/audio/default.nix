# Configure NixOS audio:
_: {
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
}
