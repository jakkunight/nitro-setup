{
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = {
      # General:
      general = {
        gaps_in = 8;
        gaps_out = 8;
        border_size = 2;
        resize_on_border = true;
      };
      # Hyprfocus:
      # Load the plugin manually
      exec-once = [
        "hyprctl plugin load ${pkgs.hyprlandPlugins.hyprfocus}/lib/libhyprfocus.so"
      ];
      plugin = {
        hyprfocus = {
          mode = "bounce";
        };
      };
      # Animations:
      animations = {
        enabled = true;
        bezier = [
          "hyprOut, 0.36, 0, 0.66, -0.56"
          "hyprIn, 0.25, 1, 0.5, 1"
          "hypr, 0.28, 0.29, 0.69, 1.08"
        ];
        animation = [
          # "hyprfocusIn, 1, 1, hyprIn"
          # "hyprfocusOut, 1, 1, hyprOut"
          "windows, 1, 4, hyprIn"
          "windowsOut, 1, 4, hyprOut"
          "windowsIn, 1, 4, hyprIn"
        ];
      };
      # Decorations:
      decoration = {
        rounding = 8;
        # Transparency:
        active_opacity = lib.mkForce 1.0;
        inactive_opacity = lib.mkForce 1.0;
        # Shadow:
        shadow = {
          enabled = true;
          range = 25;
          render_power = 3;
        };
        # Blur:
        blur = {
          enabled = false;
          size = 8;
          passes = 2;
          new_optimizations = true;
          ignore_opacity = true;
          xray = false;
          noise = 0.15;
          vibrancy = 1.2;
          brightness = 1.2;
          contrast = 1.2;
          popups = true;
        };
      };
    };
  };
}
