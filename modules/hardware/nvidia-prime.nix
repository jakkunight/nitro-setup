let
  feature = "nvidia-prime";
in
{
  flake.lib.factory.mkNvidiaPrimeConfig =
    {
      nvidiaBusId ? throw "Set your NVIDIA bus id",
      intelBusId ? throw "Set your Intel bus id",
      amdgpuBusId ? "",
    }:
    {
      nixos.${feature} =
        { lib, ... }:
        {
          hardware.nvidia.prime = {
            offload = {
              enable = true;
              enableOffloadCmd = true;
            };

            sync = {
              enable = false;
            };

            inherit nvidiaBusId intelBusId;
          }
          // lib.optionalAttrs (amdgpuBusId != "") {
            inherit amdgpuBusId;
          };

          hardware.nvidia.powerManagement = {
            enable = lib.mkDefault true;
            finegrained = lib.mkDefault false;
          };
        };
    };
}
