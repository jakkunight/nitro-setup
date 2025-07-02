{
  pkgs,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    # Use the flake package:
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    systemd.enable = false;
    settings = {
      xwayland = {
        force_zero_scaling = true;
      };
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "NVD_BACKEND,direct"
      ];
      monitor = [
        "eDP-1,preferred,auto,1.0"
      ];
      "$mod" = "SUPER";
      input = {
        kb_layout = "latam";
        follow_mouse = 1;
      };
      exec-once = [
        "uwsm app -- systemctl --user start waybar.service"
      ];

      # Cursor:
      cursor = {
        no_hardware_cursors = true;
      };
      # Keybindings
      bindel = [
        # Multimedia:
        ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
        ", XF86AudioPause, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
        ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
        ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
        ", XF86AudioMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 5%-"
      ];
      binde = [
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
      ];
      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bind = [
        # Applications:
        "$mod, Return, exec, uwsm app -- kitty"
        "$mod, D, exec, uwsm app -- ${pkgs.wofi}/bin/wofi --show drun"
        "$mod, A, exec, uwsm app -- ${pkgs.firefox}/bin/firefox"
        "$mod, S, exec, uwsm app -- ${pkgs.vlc}/bin/vlc"
        "$mod, E, exec, uwsm app -- ${pkgs.nautilus}/bin/nautilus"
        "$mod SHIFT, S, exec, uwsm app -- ${pkgs.hyprlock}/bin/hyprlock"

        # Controls:
        ", XF86LogOff, exec, uwsm stop"
        "$mod, F, fullscreen"
        "$mod, W, togglefloating"
        "$mod, Q, killactive"
        "$mod SHIFT, Q, exec, uwsm stop -r"

        # Navigation:
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

        # Move focus app to workspace:
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
        # Take a screenshot:
        " , PRINT, exec, uwsm app -- ${pkgs.hyprshot}/bin/hyprshot -m output"
        "SHIFT, PRINT, exec, uwsm app -- ${pkgs.hyprshot}/bin/hyprshot -m region"
      ];
      blurls = [
        "waybar"
        "wofi"
      ];
      # General:
      general = {
        gaps_in = 2;
        gaps_out = 10;
        border_size = 2;
        resize_on_border = true;
        no_border_on_floating = false;
        layout = "dwindle";
      };
      # Decorations:
      decoration = {
        rounding = 10;
        # Transparency:
        active_opacity = 0.80;
        inactive_opacity = 0.70;
        # Shadow:
        shadow = {
          enabled = true;
          range = 30;
          render_power = 3;
        };
        # Blur:
        blur = {
          enabled = true;
          size = 8;
          passes = 2;
          new_optimizations = true;
          ignore_opacity = true;
          xray = true;
          noise = 0;
          vibrancy = 0.1;
          brightness = 1;
          contrast = 1;
        };
      };
      # Gestures:
      gestures = {
        workspace_swipe = true;
      };
      # Layouts:
      dwindle = {
        smart_split = true;
        smart_resizing = true;
      };
      master = {
        new_status = "slave";
      };
    };
  };

  programs.hyprlock = {
    enable = true;
  };

  services = {
    hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
      };
    };
    hyprpolkitagent = {
      enable = true;
    };
    hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "${pkgs.hyprlock}/bin/hyprlock";
        };
        listener = {
          timeout = 900;
          "on-timeout" = "${pkgs.hyprlock}/bin/hyprlock";
        };
      };
    };
  };
}
