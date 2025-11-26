_: {
  programs.windowManager.hyprland.settings = {
    general = {
      layout = "";
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
      mfact = 0.7;
      new_status = "slave";
      smart_resizing = true;
      drop_at_cursor = true;
    };
  };
}
