let
  feature = "nvidia-prime";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos =
    { lib, ... }:
    {
      hardware.nvidia.prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        sync.enable = false;
        nvidiaBusId = "PCI:1:0:0";
        intelBusId = "PCI:0:2:0";
      };
      hardware.nvidia.powerManagement = {
        enable = lib.mkDefault true;
        finegrained = lib.mkDefault false;
      };
    };
}
