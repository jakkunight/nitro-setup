let
  feature = "nvidia-gpu";
in
{
  flake.modules = {
    nixos.${feature} =
      { config, ... }:
      {
        # Enable unfree packages:
        nixpkgs.config.allowUnfree = true;
        # Enable OpenGL:
        hardware.graphics = {
          # Use this from NixOS 24.11+
          enable = true;
          enable32Bit = true;
        };

        # Enable NVIDIA drivers:
        services.xserver.videoDrivers = [
          "nvidia"
        ];

        hardware.nvidia = {
          package = config.boot.kernelPackages.nvidiaPackages.beta;
          open = false;
          modesetting = {
            enable = true;
          };
          nvidiaSettings = true;
        };

        boot.kernelParams = [
          "nvidia-drm.fbdev=1"
          "NVreg_EnableGpuFirmware=0"
        ];
      };
  };
}
