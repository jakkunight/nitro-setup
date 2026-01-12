{inputs, ...}: {
  flake.modules.homeManager."desktop/nightmare/hyprland" = {
    lib,
    pkgs,
    ...
  }: {
    # Settings:
    wayland.windowManager.hyprland = {
      # Plugins:
      plugins = [
        # hyprlandPlugins.hyprfocus
        inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprfocus
      ];
      settings = {
        # General:
        general = {
          gaps_in = 8;
          gaps_out = 16;
          border_size = 4;
          resize_on_border = true;
        };
        # Hyprfocus:
        # Load the plugin manually
        exec-once = [
          "hyprctl plugin load ${inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprfocus}/lib/libhyprfocus.so"
        ];
        plugin = {
          hyprfocus = {
            mode = "flash";
            fade_opacity = 0.80;
          };
        };

        # Animations:
        animations = {
          enabled = true;
          bezier = [
            "hyprOut, 0.23, 1, 0.32, 1"
            "hyprIn, 0.755, 0.05, 0.855, 0.06"
            "hypr, 0.86, 0, 0.07, 1"
          ];
          animation = [
            "hyprfocusIn, 1, 3, hyprIn"
            "hyprfocusOut, 1, 3, hyprOut"
            "windows, 1, 4, hypr"
            "windowsOut, 1, 4, hyprOut"
            "windowsIn, 1, 4, hyprIn"
          ];
        };
        # Apply blur for Wofi and Waybar:
        layerrule = [
          "match:namespace waybar, blur on"
          "match:namespace waybar, blur_popups on"
          "match:namespace wofi, blur on"
          "match:namespace wofi, blur_popups on"
          "match:namespace wofi, xray 1"
          "match:namespace wofi, dim_around on"
        ];
        # Decorations:
        decoration = {
          rounding = 0;
          rounding_power = 0;
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
            enabled = true;
            size = 2;
            passes = 3;
            new_optimizations = true;
            ignore_opacity = true;
            xray = false;
            noise = 0.15;
            vibrancy = 1.0;
            brightness = 1.0;
            contrast = 1.0;
            popups = true;
          };
        };
      };
    };
  };
}
