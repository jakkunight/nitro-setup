{inputs, ...}: {
  flake.modules.homeManager."desktop/nightmare/hyprland" = {pkgs, ...}: {
    wayland.windowManager.hyprland.settings = {
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

      bind =
        [
          # Applications:
          "$mod, Return, exec, ${pkgs.kitty}/bin/kitty"
          # "$mod, Return, exec, ${pkgs.ghostty}/bin/ghostty"
          "$mod, D, exec, ${pkgs.wofi}/bin/wofi --show drun"
          "$mod, A, exec, ${inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.twilight}/bin/zen-twilight"
          "$mod, S, exec, ${pkgs.vlc}/bin/vlc"
          "$mod, E, exec, ${pkgs.nemo}/bin/nemo"
          "$mod SHIFT, S, exec, ${pkgs.hyprlock}/bin/hyprlock"
          "$mod SHIFT, P, exec, ${pkgs.wlogout}/bin/wlogout"

          # Controls:
          # ", XF86LogOff, stop"
          "$mod, F, fullscreen"
          "$mod, W, togglefloating"
          "$mod, Q, killactive"
          # Take a screenshot:
          " , PRINT, exec, ${pkgs.hyprshot}/bin/hyprshot -m output"
          "SHIFT, PRINT, exec, ${pkgs.hyprshot}/bin/hyprshot -m region"
          "$mod SHIFT, Q, exit"

          # # Move focus with $mod + arrow keys
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"
          # # Move focus with $mod + vim keys
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"
          # # Move windows with $mod + SHIFT + arrow keys
          "$mod SHIFT, left, movewindow, l"
          "$mod SHIFT, right, movewindow, r"
          "$mod SHIFT, up, movewindow, u"
          "$mod SHIFT, down, movewindow, d"
          # # Move windows with $mod + SHIFT + vim keys
          "$mod SHIFT, h, movewindow, l"
          "$mod SHIFT, l, movewindow, r"
          "$mod SHIFT, k, movewindow, u"
          "$mod SHIFT, j, movewindow, d"
          # Hy3:
          # Create new split:
          # "$mod ALT, t, hy3:makegroup, tab"
          # "$mod ALT, o, hy3:makegroup, opposite"
          # "$mod ALT, h, hy3:makegroup, h, toggle"
          # "$mod ALT, k, hy3:makegroup, v, toggle"
          # "$mod ALT, l, hy3:makegroup, h, toggle"
          # "$mod ALT, j, hy3:makegroup, v, toggle"
          # Toggle to tabbed window:
          # "$mod SHIFT, t, hy3:changegroup, toggletab"
        ]
        ++ (
          # Navigation:
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );
    };
  };
}
