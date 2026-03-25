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
        environment.variables = lib.mkIf (builtins.elem "nvidia" config.services.xserver.videoDrivers) {
          LIBVA_DRIVER_NAME = "nvidia";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          NIXOS_OZONE_WL = "1";
          AQ_DRM_DEVICES = "/dev/dri/card0:/dev/dri/card1";
          NVD_BACKEND = "direct";
          ELECTRON_OZONE_PLATFORM_HINT = "auto";
          OZONE_PLATFORM_HINT = "wayland";
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
          settings = {
            "$mod" = "SUPER";

            # Cursor:
            cursor = {
              no_hardware_cursors = true;
            };
            # Gestures:
            gestures = {
              workspace = true;
            };

            # Misc:
            misc = {
              disable_splash_rendering = true;
              vfr = true;
            };
          };
        };

        services = {
          hyprpolkitagent = {
            enable = true;
          };
        };
      };
  };
}
