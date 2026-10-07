let
  feature = "hyprland";
in
{ inputs, ... }:
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
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

          withUWSM = true;

          xwayland.enable = true;
        };

        environment.variables = {
          OZONE_PLATFORM_HINT = "wayland";
        };
      };

    nixos."${feature}-nvidia" =
      {
        pkgs,
        ...
      }:
      {
        # Keep the graphics stack provided by nixpkgs unless a specific
        # Hyprland/Mesa compatibility issue requires an override.
        hardware.graphics = {
          enable = true;
          enable32Bit = true;
        };

        environment.systemPackages = with pkgs; [
          nvidia-vaapi-driver
          egl-wayland
        ];
      };

    homeManager.${feature} =
      {
        pkgs,
        ...
      }:
      {
        wayland.windowManager.hyprland = {
          enable = true;

          package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

          portalPackage = pkgs.xdg-desktop-portal-hyprland;

          # UWSM owns the graphical session.
          systemd.enable = false;
        };

        services.hyprpolkitagent.enable = true;
      };
  };
}
