{
  config,
  nvidiaDrivers ? "stable",
  nvidiaBusId ? "",
  intelBusId ? "",
  amdgpuBusId ? "",
  ...
}: {
  nvidia = {
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
    prime = {
      inherit nvidiaBusId intelBusId amdgpuBusId;
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };
}
