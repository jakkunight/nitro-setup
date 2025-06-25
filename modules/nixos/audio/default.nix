# Configure NixOS audio:
{pkgs, ...}: {
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  environment.systemPackages = [
    pkgs.pavucontrol
  ];
}
