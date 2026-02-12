let
  moduleName = "nightmare-desktop";
in
  _: {
    flake.homeModules.${moduleName} = _: {
      wayland.windowManager.hyprland.settings = {
        xwayland = {
          force_zero_scaling = true;
        };
        monitor = [
          "eDP-1,preferred,auto,1"
          ",preferred,auto,1,mirror"
        ];
        exec-once = [
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        ];
      };
    };
  }
