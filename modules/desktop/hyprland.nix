let
  feature = "hyprland";
in
{ inputs, ... }:
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        # Hyprland:
        nix.settings = {
          substituters = [
            "https://hyprland.cachix.org"
          ];
          trusted-substituters = [
            "https://hyprland.cachix.org"
          ];
          trusted-public-keys = [
            "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          ];
        };

        programs.hyprland = {
          enable = true;
          package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
          portalPackage =
            inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
          withUWSM = false;
          xwayland.enable = true;
        };
        environment.variables = {
          OZONE_PLATFORM_HINT = "wayland";
        };
      };
    nixos."${feature}-nvidia" =
      {
        pkgs,
        lib,
        config,
        ...
      }:
      {
        # Hyprland:
        hardware.graphics = {
          package = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.mesa;
          enable32Bit = true;
          package32 =
            inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.pkgsi686Linux.mesa;
        };
        environment.systemPackages = with pkgs; [
          nvidia-vaapi-driver
          egl-wayland
        ];
        # Sync mode (default) - NVIDIA handles display, full power.
        # Set NVIDIA env vars for GLX/VAAPI when using sync mode.
        # In ON-THE-FLY (offload) mode, the specialisation in
        # nvidia-prime.nix overrides these to use mesa/iHD for the
        # iGPU path, so prime-run can selectively bind the dGPU.
        environment.variables = lib.mkIf (builtins.elem "nvidia" config.services.xserver.videoDrivers) {
          NIXOS_OZONE_WL = "1";
          AQ_DRM_DEVICES = "/dev/dri/card0:/dev/dri/card1";
          ELECTRON_OZONE_PLATFORM_HINT = "auto";
        };
        # Sync mode NVIDIA-specific env vars:
        # These are overridden by the ON-THE-FLY specialisation to use
        # mesa/iHD for the iGPU path.
        environment.sessionVariables =
          lib.mkIf (builtins.elem "nvidia" config.services.xserver.videoDrivers)
            {
              LIBVA_DRIVER_NAME = lib.mkDefault "nvidia";
              __GLX_VENDOR_LIBRARY_NAME = lib.mkDefault "nvidia";
              NVD_BACKEND = lib.mkDefault "direct";
            };
      };
    homeManager.${feature} =
      { pkgs, ... }:
      {
        wayland.windowManager.hyprland = {
          enable = true;
          # Use the flake package:
          # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
          # portalPackage =
          #   inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
          # Set this if using NixOS Home-Manager module:
          package = null;
          portalPackage = null;
          # Set this to true if not using UWSM:
          systemd.enable = true;
        };

        services = {
          hyprpolkitagent = {
            enable = true;
          };
        };
      };
  };
}
