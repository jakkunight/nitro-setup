let
  moduleName = "nightmare-desktop";
in
  {inputs, ...}: {
    flake.nixosModules.${moduleName} = {
      pkgs,
      config,
      ...
    }: {
      # Use the Cachix binary cache:
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

      # Enable Hyprland:
      programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        withUWSM = false;
        xwayland.enable = true;
      };
    };
    flake.homeModules.${moduleName} = {
      osConfig,
      pkgs,
      ...
    }: {
      wayland.windowManager.hyprland = {
        enable = true;
        # Use the flake package:
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        systemd.enable = true;
        settings = {
          "$mod" = "SUPER";
          input = {
            kb_layout = "latam";
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
          # hy3 = {
          # };
          # windowrule = [
          #   "match:float yes, center on"
          # ];

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
  }
