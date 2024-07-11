# Here coes my Hyprland stuffs:
{ config, lib, ... }@inputs:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Main $mod key:
      "$mod" = "SUPER";
      # Set input settings:
      input = {
        kb_layout = "latam";
        follow_mouse = 0;
      };
      # General:
      general = {
        gaps_in = 5;
        gaps_out = 10;
        "col.inactive_border" = "rgba(33ccff33) rgba(00ff9933) 45deg";
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        border_size = 2;
        resize_on_border = true;
        layout = "dwindle";
      };
      # Keybindings
      bindr = [ ];
      bind = [
        # Open a terminal:
        "$mod, X, exec, alacritty"
        # Open the file manager:
        "$mod, S, exec, thunar"
        # Open app launcher:
        "$mod, D, exec, wofi"
        # Open Web browser:
        "$mod, A, exec, firefox"
        # Open music player:
        "$mod, V, exec, vlc"
        # Toggle fullscreen:
        "$mod, F, fullscreen"
        # Toggle floating:
        "$mod, W, togglefloating"
        # Close window:
        "$mod, Q, killactive"
        # Close Hyprland:
        #"$mod SHIFT, Q, "
        # Switch workspace to:
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        # Move to workspace:
        "$mod SHIFT, 1, movetoworkspace, 0"
        "$mod SHIFT, 2, movetoworkspace, 1"
        "$mod SHIFT, 3, movetoworkspace, 2"
        "$mod SHIFT, 4, movetoworkspace, 3"
        "$mod SHIFT, 5, movetoworkspace, 4"
        "$mod SHIFT, 6, movetoworkspace, 5"
        "$mod SHIFT, 7, movetoworkspace, 6"
        "$mod SHIFT, 8, movetoworkspace, 7"
        "$mod SHIFT, 9, movetoworkspace, 8"
        "$mod SHIFT, 0, movetoworkspace, 10"
      ];
      # Decorations:
      decoration = {
        rounding = 5;
        # Transparency:
        active_opacity = 0.95;
        inactive_opacity = 0.5;
        drop_shadow = true;
        shadow_range = 4;
        shadow_offset = "0 5";
        shadow_render_power = 7;
        "col.shadow" = "rgba(000000EE)";
        # Blur:
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };
      # Animations:
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 0.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      # Gestures:
      gestures = {
        workspace_swipe = true;
      };
      # Layoouts:
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      # Misc:
      misc = {
        force_default_wallpaper = 1;
        disable_hyprland_logo = true;
      };
    };
  };
}
