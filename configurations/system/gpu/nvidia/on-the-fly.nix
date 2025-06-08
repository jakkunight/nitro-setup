{
  cfg,
  pkgs,
  ...
}: {
  hardware.nvidia.prime = {
    offload.enable = true;
    inherit (cfg) intelBusId nvidiaBusId;
  };

  environment.systemPackages = with pkgs; [glxinfo];
}
