{
  withSystem,
  lib,
  config,
  ...
}: let
  inherit (lib) types mkOption mkIf;
in {
  options = let
    inherit (types) submodule nullOr enum nonEmptyStr;
    nvidiaConfigType = submodule {
      options = {
        package = mkOption {
          type = enum [
            "stable"
            "beta"
          ];
          default = "stable";
        };
      };
      iGpuBusId = mkOption {
        type = nonEmptyStr;
        default = "PCI:1@0:0:0";
      };
      nvidiaBusId = mkOption {
        type = nonEmptyStr;
        default = "PCI:1@0:0:0";
      };
    };
  in {
    nvidiaConfig = mkOption {
      type = nullOr nvidiaConfigType;
      default = null;
    };
  };
  config = {
    flake.modules.nixos."hardware/gpu" = mkIf (config.gpuClass == "nvidia") {
      # Allow unfree software:
      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.allowUnfreePredicate = _: true;

      # Configure NVIDIA propertary drivers:
      hardware.graphics.enable = true;
      services.xserver.videoDrivers = ["nvidia"];
      hardware.nvidia = {
        enabled = true;
        # Choose your driver package:
        package = config.boot.kernelPackages.nvidiaPackages.${config.nvidiaConfig.package};
        gsp.enable = true;
        datacenter = {
          enable = true;
          settings = {
            LOG_LEVEL = 4;
            LOG_FILE_NAME = "/var/log/fabricmanager.log";
            LOG_APPEND_TO_LOG = 1;
            LOG_FILE_MAX_SIZE = 1024;
            LOG_USE_SYSLOG = 0;
            DAEMONIZE = 1;
            BIND_INTERFACE_IP = "127.0.0.1";
            STARTING_TCP_PORT = 16000;
            FABRIC_MODE = 0;
            FABRIC_MODE_RESTART = 0;
            STATE_FILE_NAME = "/var/tmp/fabricmanager.state";
            FM_CMD_BIND_INTERFACE = "127.0.0.1";
            FM_CMD_PORT_NUMBER = 6666;
            FM_STAY_RESIDENT_ON_FAILURES = 0;
            ACCESS_LINK_FAILURE_MODE = 0;
            TRUNK_LINK_FAILURE_MODE = 0;
            NVSWITCH_FAILURE_MODE = 0;
            ABORT_CUDA_JOBS_ON_FM_EXIT = 1;
          };
        };
        dynamicBoost.enable = true;
        prime = {
          nvidiaBusId = "${config.nvidiaConfig.nvidiaBusId}";
          amdgpuBusId = mkIf (config.cpuVendor == "amd") config.nvidiaConfig.iGpuBusId;
          intelBusId = mkIf (config.cpuVendor == "intel") config.nvidiaConfig.iGpuBusId;
          sync.enable = lib.mkDefault true;
        };

        # Specialisations:
        specialisation.on-the-go.configuration = {
          system.nixos.tags = ["on-the-go"];
          hardware.nvidia.prime = {
            offload = {
              enable = lib.mkForce true;
              enableOffloadCmd = lib.mkForce true;
            };
            sync.enable = lib.mkForce false;
          };
        };
      };
    };
  };
}
