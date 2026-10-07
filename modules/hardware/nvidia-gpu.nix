let
  feature = "nvidia-gpu";
in
{
  flake.modules.nixos.${feature} =
    {
      config,
      pkgs,
      ...
    }:
    {
      nixpkgs.config.allowUnfree = true;

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      services.xserver.videoDrivers = [
        "modesetting"
        "nvidia"
      ];

      hardware.nvidia = {
        # Use the stable NVIDIA driver from the current kernel package set.
        package = config.boot.kernelPackages.nvidiaPackages.stable;

        # NVIDIA open kernel module.
        # Recommended for supported Turing+ GPUs.
        open = true;

        # Required/recommended for Wayland.
        modesetting.enable = true;

        nvidiaSettings = true;

        # Keep the persistence daemon available.
        nvidiaPersistenced = true;

        # Enable suspend/resume VRAM preservation.
        powerManagement.enable = true;
      };

      boot.kernelParams = [
        "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
        "nvidia.NVreg_TemporaryFilePath=/var/tmp"
      ];

      boot.initrd.kernelModules = [
        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ];

      environment.systemPackages = with pkgs; [
        nvtopPackages.nvidia
        lshw
        pciutils
        mesa-demos
        vulkan-tools
        libva-utils
        vdpauinfo
        egl-wayland
      ];
    };
}
