_: {
  flake.modules.homeManager."desktop/nightmare/hyprland" = _: {
    wayland.windowManager.hyprland.settings = {
      # Select active layout:
      general = {
        layout = "master";
      };
      # Layouts:
      dwindle = {
        smart_split = false;
        smart_resizing = true;
        pseudotile = false;
        preserve_split = true;
        force_split = 2;
      };
      master = {
        mfact = 0.60;
        orientation = "left";
        new_status = "master";
        smart_resizing = true;
        drop_at_cursor = false;
      };
      bind = [
        "$mod, R, layoutmsg, swapwithmaster"
        "$mod, M, layoutmsg, cyclenext"
        "$mod, N, layoutmsg, cycleprev"
      ];
    };
  };
}
