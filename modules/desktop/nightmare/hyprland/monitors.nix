_: {
  flake.modules.homeManager."desktop/nightmare/hyprland" = _: {
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
