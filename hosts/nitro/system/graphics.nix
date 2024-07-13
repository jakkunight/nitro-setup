# Here goes any graphic related config:
{ config, lib, pkgs, ... }@inputs: {
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = false;
  services.xserver.desktopManager.xfce.enable = true;

  # Enable OpenGL:
  hardware.graphics = {
    # Use this from NixOS 24.11+
    enable = true;
    enable32Bit = true;
  };

  # Enable NVIDIA drivers:
  services.xserver.videoDrivers = [
    "nvidia"
  ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.production;
    modesetting = {
      enable = true;
    };
    powerManagement = {
      enable = false;
      finegrained = false;
    };
    nvidiaSettings = true;
    prime = {
      # Sync mode will drain all your battery (default):
      sync.enable = true;

      # Offload will save some battery.
      #offload = {
      #  enable = true;
      #  enableOffloadCmd = true;
      #};

      # BusId is mandatory:
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # Define a special mode for using the offload mode:
  specialisation = {
    on-the-go.configuration = {
      system.nixos.tags = [ "on-the-go" ];
      hardware.nvidia = {
        prime.offload.enable = lib.mkForce true;
        prime.offload.enableOffloadCmd = lib.mkForce true;
        prime.sync.enable = lib.mkForce false;
      };
    };
  };

  # Hyprland:
  imports = [
    ./hyprland.nix
  ];
}
