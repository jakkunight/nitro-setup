# Here goes the services config:
{}: {
  # Enable EnvFS to fix shebangs
	services.envfs.enable = true;
  # Configure keymap in X11
  services.xserver.xkb.layout = "latam";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # DBUS:
  services.dbus.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # USB external drives:
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # IPSec:
  imports = [
    ./strongswan.nix
  ];

  # Xfce services:
  # services.xserver.desktopManager.xfce.enable = true;
  # services.xserver.desktopManager.xfce.noDesktop = true;
}
