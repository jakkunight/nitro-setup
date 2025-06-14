{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption types mkEnableOption;
  cfg = config.options.modules.system.nvidia;
  configsPath = ../../../configs/system/nvidia;
in {
  imports = [];
  options.modules.system.nvidia = {
    enable = mkEnableOption "Weather to enable the Nvidia GPU module.";
    driverPackage = mkOption {
      description = "The package to use for the Nvidia drivers.";
      type = types.enum lib.attrNames config.boot.kernelPackages.nvidiaPackages;
      default = "stable";
    };
    nvidiaBusId = mkOption {
      description = "Provides the Nvidia PCI bus ID.";
      type = types.nonEmptyString;
      default = "";
    };
    intelBusId = mkOption {};
    amdBusId = mkOption {};
  };
  config = mkIf cfg.enable {
    # Enable OpenGL:
    hardware.graphics = {
      # Use this from NixOS 24.11+
      enable = true;
      enable32Bit = true;
    };

    # Enable NVIDIA drivers for X11:
    services.xserver.videoDrivers = [
      "nvidia"
    ];

    hardware.nvidia = import configsPath + "";
  };
}
