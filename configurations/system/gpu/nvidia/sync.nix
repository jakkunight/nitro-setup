{
  cfg,
  pkgs,
  ...
}: {
  hardware.nvidia.prime = {
    sync.enable = true;
    inherit (cfg) intelBusId nvidiaBusId;
  };
  environment.systemPackages = with pkgs; [glxinfo];
}
