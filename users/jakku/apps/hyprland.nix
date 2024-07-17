# Hyprland user config:
{ config, pkgs, lib, ... }:
{
  # Hyprland:
  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
    };
    settings = {
      # Monitor:
      monitor = ",preferred,auto,1.0";
      # Main $mod key:
      "$mod" = "SUPER";
      # Set input settings:
      input = {
        kb_layout = "latam";
        follow_mouse = 0;
      };
      exec = [
        "swww-daemon &"
        "swww img ~/Pictures/wanderer-inazuma.jpg &"
      ];
      # General:
      general = {
        gaps_in = 5;
        gaps_out = 10;
        "col.inactive_border" = "rgba(33ccff33) rgba(00ff9933) 45deg";
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        border_size = 2;
        resize_on_border = true;
        layout = "master";
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
      bindr = [ ];
      bind = [
        # Open a terminal:
        "$mod, Return, exec, alacritty"
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
        "$mod SHIFT, Q, exit"
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
      master = {
        new_status = "slave";
      };
      # Misc:
      misc = {
        force_default_wallpaper = 1;
        disable_hyprland_logo = true;
      };
    };
  };

  # Hyprlock:
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
      };
      backgrounds = [
        {
          monitor = "";
          path = "~/Pictures/lock-screen.jpg";
          color = "rgba(0, 0, 0, 0.5)";
          blur_passes = 4;
          blur_size = 2;
          noise = 0.1;
          contrast = 0.8;
          brightness = 0.5;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];
      input-fields = [
        {
          monitor = "";
          size = {
            width = 600;
            height = 50;
          };
          outline_thickness = 0.3;
          fade_on_empty = true;
          placeholder_text = ''<i>Password</i>'';
          outer_color = "";
          inner_color = "";
          font_color = "";
          dots_size = 0.2;
          dots_spacing = 0.1;
          dots_center = true;
          position = {
            x = 0;
            y = 50;
          };
          halign = "center";
          valign = "center";
        }
      ];

      labels = [{
        monitor = "";
        text = "$TIME";
        font_family = "Cascadia Code";
        font_size = 64;
        color = "rgba(200, 200, 200, 1.0)";
        position = {
          x = 0;
          y = 90;
        };
        valign = "center";
        halign = "center";
      }
        {
          monitor = "";
          text = "Hey $USER";
          color = "rgba(200, 200, 200, 1.0)";
          font_size = 20;
          position = {
            x = 0;
            y = 0;
          };
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "Type to unlock!";
          color = "rgba(200, 200, 200, 1.0)";
          font_size = 16;
          position = {
            x = 0;
            y = 30;
          };
          halign = "center";
          valign = "bottom";
        }];
    };
  };
  services.hyprpaper = {
    enable = true;
    settings = {
      wallpaper = [
        ",$HOME/Pictures/kali-night-skyA-1920x1080.png"
      ];
    };
  };
}
