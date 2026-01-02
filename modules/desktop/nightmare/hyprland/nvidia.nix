{inputs, ...}: {
  flake.modules.nixos."desktop/nightmare/hyprland/nvidia" = {pkgs, ...}: {
    hardware.graphics = {
      package32 = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.pkgsi686Linux.mesa;
      enable32Bit = true;
    };
  };
  flake.modules.homeManager."desktop/nightmare/hyprland/nvidia" = _: {
    wayland.windowManager.hyprland.settings = {
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "NVD_BACKEND,direct"
      ];
    };
  };
}
