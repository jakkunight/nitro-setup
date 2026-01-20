{inputs, ...}: let
  moduleName = "desktop/nightmare/hyprland";
in {
  flake.modules = {
    nixos.${moduleName} = {
      pkgs,
      lib,
      ...
    }: {
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
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        withUWSM = false;
        xwayland.enable = true;
      };

      programs.uwsm = {
        enable = false;
        package = pkgs.uwsm;
        waylandCompositors = {
          hyprland = {
            prettyName = lib.mkForce "Hyprland";
            comment = "Hyprland compositor managed by UWSM";
            binPath = lib.mkForce "/run/current-system/sw/bin/Hyprland";
          };
        };
      };
    };
    homeManager.${moduleName} = {
      pkgs,
      config,
      osConfig,
      ...
    }: {
      xdg.configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
      wayland.windowManager.hyprland = {
        enable = true;
        # Use the flake package:
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        # package = null;
        # portalPackage = null;
        # Set this to true if using UWSM:
        systemd.enable = !(osConfig.programs.hyprland.withUWSM && osConfig.programs.uwsm.enable);
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
  };
}
