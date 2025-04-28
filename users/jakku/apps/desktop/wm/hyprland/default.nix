# Hyprland user config:
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  # Hyprland:
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    #plugins = [ inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.system}.hyprlandPlugins.hy3 ];
    #plugins = [ pkgs.hyprlandPlugins.hy3 ];
    settings = {
      # ENV Variables:
      env = [
        "XCURSOR_SIZE,36"
        "XDG_SESSION_TYPE,wayland"
      ];
      # XWayland:
      xwayland = {
        force_zero_scaling = true;
      };
      # Monitor:
      monitor = ",preferred,auto,1.0";
      # Main $mod key:
      "$mod" = "SUPER";
      # Set input settings:
      input = {
        kb_layout = "latam";
        follow_mouse = 1;
      };
      exec = [
        #"swww-daemon &"
        #"swww img ~/Pictures/wanderer-inazuma.jpg"
        #"swww img ~/Pictures/wanderer.gif"
        #"mpvpaper -o 'no-audio --loop-playlist shuffle' '*' ~/Pictures/Wanderer.mp4 &"
      ];
      exec-once = [
        "uwsm app -- systemctl --user enable --now hyprpaper.service"
        "uwsm app -- systemctl --user start hyprpolkitagent"
        "uwsm app -- systemctl --user start waybar.service"
        #"hyprpanel"
        #"${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &"
      ];
      # General:
      general = {
        gaps_in = 1;
        gaps_out = 2;
        "col.inactive_border" = "rgba(3d59a1ff) rgba(41a6b5ff) 45deg";
        "col.active_border" = "rgba(7dcfffff) rgba(c3e88dff) 45deg";
        border_size = 0;
        resize_on_border = true;
        layout = "dwindle";
      };
      # Cursor:
      cursor = {
        no_hardware_cursors = true;
      };
      # Keybindings
      bindel = [
        # Multimedia:
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];
      bindl = [
        # Multimedia:
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
      ];
      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bind = [
        # Open a terminal:
        "$mod, Return, exec, uwsm app -- kitty"
        # Open the file manager:
        "$mod, E, exec, uwsm app -- nemo"
        # Open app launcher:
        "$mod, D, exec, uwsm app -- wofi --show drun"
        # Open Web browser:
        #"$mod, A, exec, flatpak run io.github.zen_browser.zen"
        "$mod, A, exec, uwsm app -- firefox"
        # Open music player:
        "$mod, S, exec, uwsm app -- vlc"
        # Toggle fullscreen:
        "$mod, F, fullscreen"
        # Toggle floating:
        "$mod, W, togglefloating"
        # Close window:
        "$mod, Q, killactive"
        # Lock screen:
        "$mod SHIFT, S, exec, uwsm app -- hyprlock"
        # Close Hyprland:
        "$mod SHIFT, Q, exit"
        # Reboot:
        "$mod SHIFT, R, exec, systemctl reboot"
        # Poweroff:
        "$mod SHIFT, P, exec, systemctl poweroff"

        # Hot-reloading:
        #"$mod R, exec, hyprctl reload"
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
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        # Move focus with $mod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        # Move focus with $mod + vim keys
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"
        # Move windows with $mod + SHIFT + arrow keys
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"
        # Move windows with $mod + SHIFT + vim keys
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, l, movewindow, r"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, j, movewindow, d"
        # Resize windows with $mod + CTRL + arrow keys
        "$mod CTRL, left, resizeactive, -1% 0%"
        "$mod CTRL, right, resizeactive, 1% 0%"
        "$mod CTRL, up, resizeactive, 0% 1%"
        "$mod CTRL, down, resizeactive, 0% -1%"
        # Resize windows with $mod + CTRL + vim keys
        "$mod CTRL, h, resizeactive, -1% 0%"
        "$mod CTRL, l, resizeactive, 1% 0%"
        "$mod CTRL, k, resizeactive, 0% 1%"
        "$mod CTRL, j, resizeactive, 0%% -1%"
        # Take a screenshot:
        " , PRINT, exec, uwsm app -- hyprshot -m output"
        "SHIFT, PRINT, exec, uwsm app -- hyprshot -m region"
      ];
      # Decorations:
      decoration = {
        rounding = 10;
        # Transparency:
        active_opacity = 0.90;
        inactive_opacity = 0.85;
        # Shadow:
        shadow = {
          enabled = true;
          range = 10;
          render_power = 2;
          color = "rgba(7dcfffaa)";
          color_inactive = "rgba(4fd6beaa)";
        };
        # Blur:
        blur = {
          enabled = true;
          size = 10;
          passes = 2;
          new_optimizations = true;
          ignore_opacity = true;
          xray = true;
          blurls = "waybar";
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
        force_split = 2;
        smart_split = true;
        smart_resizing = true;
      };
      master = {
        new_status = "slave";
      };
      hy3 = {
        #no_gaps_when_only = 0;
      };
      # Misc:
      misc = {
        force_default_wallpaper = 1;
        disable_hyprland_logo = true;
      };
      # Window rules:
      #windowrulev2 = ["pseudo, class:^.*(wezterm).*$"];
    };
  };
}
