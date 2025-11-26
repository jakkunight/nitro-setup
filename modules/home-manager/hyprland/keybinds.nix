{
  pkgs,
  inputs,
  ...
}: {
  programs.windowManager.hyprland.settings = {
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
      "$mod, Return, exec, ${pkgs.uwsm}/bin/uwsm app -- ${pkgs.kitty}/bin/kitty"
      "$mod, D, exec, ${pkgs.uwsm}/bin/uwsm app -- ${pkgs.wofi}/bin/wofi --show drun"
      "$mod, A, exec, ${pkgs.uwsm}/bin/uwsm app -- ${inputs.zen-browser.packages.${pkgs.system}.beta}/bin/zen-beta"
      "$mod, S, exec, ${pkgs.uwsm}/bin/uwsm app -- ${pkgs.vlc}/bin/vlc"
      "$mod, E, exec, ${pkgs.uwsm}/bin/uwsm app -- ${pkgs.nemo}/bin/nemo"
      "$mod SHIFT, S, exec, ${pkgs.uwsm}/bin/uwsm app -- ${pkgs.hyprlock}/bin/hyprlock"

      # Controls:
      ", XF86LogOff, exec, ${pkgs.uwsm}/bin/uwsm stop"
      "$mod, F, fullscreen"
      "$mod, W, togglefloating"
      "$mod, Q, killactive"
      "$mod SHIFT, Q, exec, ${pkgs.uwsm}/bin/uwsm stop -r"

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
      # Take a screenshot:
      " , PRINT, exec, uwsm app -- ${pkgs.hyprshot}/bin/hyprshot -m output"
      "SHIFT, PRINT, exec, uwsm app -- ${pkgs.hyprshot}/bin/hyprshot -m region"
    ];
  };
}
