let
  feature = "nvidia-prime";
in
{
  flake.factory.mkNvidiaPrimeConfig =
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
              enable = false;
              finegrained = false;
            };
            prime = {
              # Sync mode will drain all your battery (default):
              sync.enable = true;

              # Offload will save some battery.
              #offload = {
              #  enable = true;
              #  enableOffloadCmd = true;
              #}

              # BusId is mandatory. It may be extracted from your machine:
              inherit nvidiaBusId intelBusId amdgpuBusId;
            };
          };

          # Define a special mode for using the offload mode:
          specialisation = {
            ON-THE-FLY.configuration = {
              system.nixos.tags = [ "ON-THE-FLY" ];
              hardware.nvidia = {
                prime.offload.enable = lib.mkForce true;
                prime.offload.enableOffloadCmd = lib.mkForce true;
                prime.sync.enable = lib.mkForce false;
              };
            };
          };
        };
    };
}
