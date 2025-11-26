_: {
  programs.windowManager.hyprland.settings = {
    # General:
    general = {
      gaps_in = 8;
      gaps_out = 8;
      border_size = 2;
      resize_on_border = true;
    };
    # Decorations:
    decoration = {
      rounding = 8;
      # Transparency:
      # active_opacity = lib.mkForce 0.90;
      # inactive_opacity = lib.mkForce 0.80;
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
}
