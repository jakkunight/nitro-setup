let
  moduleName = "nightmare-desktop";
in
  {inputs, ...}: {
    flake.homeModules.${moduleName} = {
      osConfig,
      pkgs,
      ...
    }: {
      programs.hyprland.settings = {
        "$mod" = "SUPER";
        input = {
          kb_layout = "latam";
          follow_mouse = 0;
        };
        cursor = {
          no_hardware_cursors = false;
        };
        gestures = {
          workspace = true;
        };
        misc = {
          disable_splash_rendering = true;
          vfr = true;
        };
        bind = [
          # Main applications:
          # Terminal (Kitty):
          "$mod, Return, exec, ${pkgs.kitty}/bin/kitty"
          # App Launcher (Wofi):
          "$mod, D, exec, ${pkgs.wofi}/bin/wofi --show drun"
          # Controls:
          "$mod, F, fullscreen"
          "$mod, W togglefloating"
          "$mod, Q, killactive"

          "$mod, right, movefocus, r"
          "$mod, left, movefocus, l"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"
        ];
      };
    };
  }
