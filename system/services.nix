# Here goes the services config:
{}: {
  # Configure keymap in X11
  services.xserver.xkb.layout = "latam";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;
}
