{inputs, ...}: {
  flake.modules = {
    nixos."desktop/nightmare/hyprland" = {pkgs, ...}: {
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
        withUWSM = true;
        xwayland.enable = true;
      };

      hardware.graphics = {
        package32 = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.pkgsi686Linux.mesa;
        enable32Bit = true;
      };
    };
    homeManager."desktop/nightmare/hyprland" = {pkgs, ...}: {
      wayland.windowManager.hyprland = {
        enable = true;
        # Use the flake package:
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        systemd.enable = false;
        settings = {
          "$mod" = "SUPER";
          input = {
            kb_layout = "latam";
            follow_mouse = 1;
          };
          exec-once = [
            "uwsm app -- systemctl --user start waybar.service"
            # "${pkgs.uwsm}/bin/uwsm app -- ${inputs.quickshell.packages.${pkgs.system}.default}/bin/quickshell"
            # "${pkgs.uwsm}/bin/uwsm app -- ${pkgs.quickshell}/bin/quickshell"
          ];

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
