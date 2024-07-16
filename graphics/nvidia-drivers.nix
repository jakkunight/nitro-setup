# NVIDIA Drivers config:
{ config, lib, ... }:
{
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

      # BusId is mandatory. It may be extracted from your machine:
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

}
