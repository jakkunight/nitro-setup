let
  moduleName = "nightmare-desktop";
in
  {inputs, ...}: {
    flake.nixosModules.${moduleName} = {lib, ...}: {
      options = {
        nightmare-desktop = {
          withNvidiaSupport = lib.mkEnableOption "Wether to enable or not the NVIDIA support.";
        };
      };
    };
  }
