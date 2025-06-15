{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption types mkEnableOption;
  cfg = config.modules.system.nvidia;
  configsPath = ../../../configs/system/nvidia;
  profiles = builtins.readDir configsPath;
  selectedConfig = configsPath + "/${cfg.profile}";
in {
  options.modules.system.nvidia = {
    enable = mkEnableOption "Weather to enable the Nvidia GPU module.";
    profile = mkOption {
      description = "The selected profile for the Nvidia GPU.";
      type = types.enum (builtins.attrNames profiles);
      default = "on-the-fly";
    };
    nvidiaDrivers = mkOption {
      description = "The package to use for the Nvidia drivers.";
      type = types.enum (lib.attrNames config.boot.kernelPackages.nvidiaPackages);
      default = "stable";
    };
    nvidiaBusId = mkOption {
      description = "Provides the Nvidia PCI bus ID.";
      type = types.nonEmptyStr;
      default = "";
    };
    intelBusId = mkOption {
      description = "Provides the Intel PCI bus ID.";
      type = types.string;
      default = "";
    };
    amdgpuBusId = mkOption {
      description = "Provides the AMD PCI bus ID.";
      type = types.string;
      default = "";
    };
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

    hardware.nvidia =
      (import selectedConfig {
        inherit config lib;
        inherit (cfg) nvidiaBusId nvidiaDrivers intelBusId amdgpuBusId;
      }).nvidia;
  };
}
