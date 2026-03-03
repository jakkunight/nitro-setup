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
      };
    homeManager.${feature} =
      { pkgs, ... }:
      {
        wayland.windowManager.hyprland = {
          enable = true;
          # Use the flake package:
          package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
          portalPackage =
            inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
          # Set this to true if using UWSM:
          systemd.enable = true;
          settings = {
            "$mod" = "SUPER";
            input = {
              follow_mouse = 1;
            };

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
