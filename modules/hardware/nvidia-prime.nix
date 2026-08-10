let
  feature = "nvidia-prime";
in
{
  flake.lib.factory.mkNvidiaPrimeConfig =
    {
      nvidiaBusId ? throw "Set your NVIDIA bus id",
      intelBusId ? throw "Set your Intel bus id",
      amdgpuBusId ? throw "Set your AMD bus id",
    }:
    {
      nixos.${feature} =
        { lib, ... }:
        {
          hardware.nvidia = {
            powerManagement = {
              enable = lib.mkDefault false;
              finegrained = lib.mkDefault false;
            };
            prime = {
              # Sync mode will drain all your battery (default):
              sync.enable = lib.mkDefault true;

              # Offload will save some battery.
              #offload = {
              #  enable = true;
              #  enableOffloadCmd = true;
              #}

              # BusId is mandatory. It may be extracted from your machine:
              inherit nvidiaBusId intelBusId amdgpuBusId;
            };
          };

          # Define specialisations for switching between sync and offload modes:
          specialisation = {
            # Sync mode - NVIDIA handles the internal display, full power:
            sync.configuration = {
              system.nixos.tags = [ "sync" ];
              hardware.nvidia = {
                powerManagement.enable = lib.mkForce false;
                prime = {
                  sync.enable = lib.mkForce true;
                  offload = {
                    enable = lib.mkForce false;
                    enableOffloadCmd = lib.mkForce false;
                  };
                };
              };
              environment.sessionVariables = {
                __GLX_VENDOR_LIBRARY_NAME = lib.mkForce "nvidia";
                NVD_BACKEND = lib.mkForce "direct";
              };
            };

            # Offload / Optimus Prime mode - Intel iGPU handles display,
            # NVIDIA offloads on-demand via prime-run:
            ON-THE-FLY.configuration = {
              system.nixos.tags = [ "ON-THE-FLY" ];
              hardware.nvidia = {
                powerManagement.enable = lib.mkForce true;
                prime = {
                  sync.enable = lib.mkForce false;
                  offload = {
                    enable = lib.mkForce true;
                    enableOffloadCmd = lib.mkForce true;
                  };
                };
              };
              environment.sessionVariables = {
                # Use mesa for GLX by default so iGPU is used; prime-run
                # overrides this for dGPU apps:
                __GLX_VENDOR_LIBRARY_NAME = lib.mkForce "mesa";
                NVD_BACKEND = lib.mkForce "direct";
                LIBVA_DRIVER_NAME = "iHD";
              };
              boot.kernelParams = [
                "NVreg_DynamicPower=0x02"
              ];
            };
          };
        };
    };
}
