# Here goes the services config:
{ configs, pkgs, lib, ... }@inputs: {
  # Enable X11:
  services.xserver.enable = true;
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
  services.udiskie = {
    enable = true;
    notify = true;
    try = true;
  };
  environment.systemPackages = with pkgs; [
    usbutils
    udisks2
    udiskie
    gvfs
    xfce.thunar
  ];

  # GNOME services:
  services.desktopManager.gnome.enable = true;
}
