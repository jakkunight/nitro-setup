let
  feature = "nvidia-gpu";
in
{
  flake.modules = {
    nixos.${feature} =
      {
        config,
        pkgs,
        lib,
        ...
      }:
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
          "modsetting"
          "nvidia"
        ];

        hardware.nvidia = {
          package = config.boot.kernelPackages.nvidiaPackages.production;
          # Use open = lib.mkDefault false; for compatibility.
          # For newer cards (RTX 30xx/40xx), set open = true via
          # your host config or specialisation to use the open-source
          # kernel driver.
          open = lib.mkDefault false;
          modesetting = {
            enable = true;
          };
          nvidiaSettings = true;
        };

        boot.kernelParams = [
          "nvidia-drm.fbdev=1"
          "NVreg_EnableGpuFirmware=0"
        ];

        environment.systemPackages = with pkgs; [
          nvtopPackages.nvidia
        ];
      };
  };
}
