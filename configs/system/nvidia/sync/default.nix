{
  config,
  nvidiaDrivers ? "stable",
  nvidiaBusId ? "",
  intelBusId ? "",
  amdBusId ? "",
  ...
}: {
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.${nvidiaDrivers};
    modesetting = {
      enable = true;
    };
    powerManagement = {
      enable = false;
      finegrained = false;
    };
    open = true;
    nvidiaSettings = true;
    inherit nvidiaBusId intelBusId amdBusId;
    prime = {
      sync.enable = true;
    };
  };
}
