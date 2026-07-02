let
  feature = "nightmare-hyprland";
in
{
  self,
  inputs,
  ...
}:
{
  flake.modules.homeManager.${feature} =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      toLua = x: lib.generators.mkLuaInline x;
    in
    {
      imports = with self.modules.homeManager; [
        hyprland
      ];
      wayland.windowManager.hyprland = {
        enable = true;
        configType = "lua";
        settings = {
          config = {
            general = {
              locale = "es_PY";
              # master layout for now:
              layout = "master";
              border_size = 2;
              gaps_in = 2;
              gaps_out = 4;
              gaps_workspaces = 0;
              float_gaps = 0;
              resize_on_border = true;
              extend_border_grab_area = true;
              hover_icon_on_border = true;
              allow_tearing = true;
              modal_parent_blocking = true;
              # snap = { };
            };
            decoration = {
              rounding = 16;
              # rounding_power = 1.0;
              blur = {
                enabled = true;
                size = 4;
                passes = 1;
                ignore_opacity = true;
                new_optimizations = true;
                xray = true;
                contrast = 1.2;
                brightness = 1.2;
              };
              shadow = {
                enabled = true;
              };
              glow = {
                enabled = false;
              };
            };
            input = {
              kb_layout = "latam";
              follow_mouse = 0;
              mouse_refocus = true;
            };
            group = {
              auto_group = true;
              groupbar = {
                enabled = true;
              };
            };
            misc = {
              disable_hyprland_logo = true;
              disable_splash_rendering = true;
            };
          };
          monitor = [
            {
              output = "eDP-1";
              mode = "preferred";
              position = "0x0";
              scale = 1;
            }
            {
              output = "";
              mode = "highres";
              position = "auto-right";
              scale = 1;
            }
          ];

          workspace_rule = [
            {
              workspace = "r[1-7]";
              monitor = "eDP-1";
              persistent = true;
            }
          ];

          # ---- BINDS ----

          bind = [
            {
              _args = [
                "SUPER + RETURN"
                (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.kitty}/bin/kitty")'')
              ];
            }
            {
              _args = [
                "SUPER + SPACE"
                (lib.generators.mkLuaInline ''
                  hl.dsp.exec_cmd("${pkgs.wofi}/bin/wofi --show drun")
                '')
              ];
            }
            {
              _args = [
                "Print"
                (lib.generators.mkLuaInline ''
                  hl.dsp.exec_cmd("${pkgs.hyprshot}/bin/hyprshot -m active -m output")
                '')
              ];
            }
            {
              _args = [
                "SHIFT + Print"
                (lib.generators.mkLuaInline ''
                  hl.dsp.exec_cmd("${pkgs.hyprshot}/bin/hyprshot -m region")
                '')
              ];
            }
            {
              _args = [
                "SUPER + Q"
                (lib.generators.mkLuaInline ''
                  hl.dsp.window.close()
                '')
              ];
            }
            {
              _args = [
                "SUPER + W"
                (lib.generators.mkLuaInline ''
                  hl.dsp.window.float()
                '')
              ];
            }
            {
              _args = [
                "SUPER + E"
                (lib.generators.mkLuaInline ''
                  hl.dsp.exec_cmd("${pkgs.kitty}/bin/kitty sh -c '${pkgs.yazi}/bin/yazi'", { float = true, center = true, size = {"(monitor_w*0.5)", "(monitor_h*0.5)"} })
                '')
              ];
            }
            {
              _args = [
                "SUPER + R"
                (lib.generators.mkLuaInline ''
                  hl.dsp.exec_cmd("${pkgs.kitty}/bin/kitty sh -c '${pkgs.rmpc}/bin/rmpc --address 127.0.0.1:6600'", { float = true, center = true, size = {"(monitor_w*0.5)", "(monitor_h*0.5)"} })
                '')
              ];
            }
            {
              _args = [
                "SUPER + T"
                (lib.generators.mkLuaInline ''
                  hl.dsp.exec_cmd("${pkgs.kitty}/bin/kitty sh -c '${pkgs.networkmanager}/bin/nmtui'", { float = true, center = true, size = {"(monitor_w*0.5)", "(monitor_h*0.5)"} })
                '')
              ];
            }
            {
              _args = [
                "SUPER + A"
                (lib.generators.mkLuaInline ''
                  hl.dsp.exec_cmd("${
                    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.twilight
                  }/bin/zen-twilight")
                '')
              ];
            }
            {
              _args = [
                "SUPER + S"
                (lib.generators.mkLuaInline ''
                  hl.dsp.exec_cmd("${pkgs.vlc}/bin/vlc", { float = true, center = true, size = {"(monitor_w*0.5)", "(monitor_h*0.5)"} })
                '')
              ];
            }
            {
              _args = [
                "SUPER + D"
                # (lib.generators.mkLuaInline ''
                #   hl.dsp.exec_cmd("${pkgs.kitty}/bin/kitty sh -c '${pkgs.helix}/bin/hx'", { float = true, center = true, size = {"(monitor_w*0.5)", "(monitor_h*0.5)"} })
                # '')
                (toLua ''
                  hl.dsp.exec_cmd("${pkgs.wofi}/bin/wofi --show drun")
                '')
              ];
            }
            {
              _args = [
                "SUPER + F"
                (lib.generators.mkLuaInline ''
                  hl.dsp.window.fullscreen()
                '')
              ];
            }
            {
              _args = [
                "SUPER + G"
                (lib.generators.mkLuaInline ''
                  hl.dsp.window.center()
                '')
              ];
            }
            {
              _args = [
                "SUPER + Z"
                (toLua ''
                  hl.dsp.exec_cmd("${pkgs.hyprlock}/bin/hyprlock")
                '')
              ];
            }
            {
              _args = [
                "SUPER + C"
                (toLua ''
                  hl.dsp.exec_cmd("${pkgs.kitty}/bin/kitty sh -c '${pkgs.clock-rs}/bin/clock-rs'", { float = true, center = true, size = { 600, 480 } })
                '')
              ];
            }
            {
              _args = [
                "SUPER + V"
                (toLua ''
                  hl.dsp.exec_cmd("${pkgs.kitty}/bin/kitty sh -c '${pkgs.btop}/bin/btop'", { float = true, center = true, size = {"(monitor_w*0.5)", "(monitor_h*0.5)"} })
                '')
              ];
            }
            # Mouse controls
            {
              _args = [
                "SUPER + mouse:272"
                (lib.generators.mkLuaInline ''
                  hl.dsp.window.drag()
                '')
                { mouse = true; }
              ];
            }
            {
              _args = [
                "SUPER + mouse:273"
                (lib.generators.mkLuaInline ''
                  hl.dsp.window.resize()
                '')
                { mouse = true; }
              ];
            }
            # Multimedia controls
            {
              _args = [
                "XF86AudioRaiseVolume"
                (toLua ''
                  hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+")
                '')
                {
                  locked = true;
                  repeating = true;
                }
              ];
            }
            {
              _args = [
                "XF86AudioLowerVolume"
                (toLua ''
                  hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-")
                '')
                {
                  locked = true;
                  repeating = true;
                }
              ];
            }
            {
              _args = [
                "XF86AudioMute"
                (toLua ''
                  hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
                '')
                {
                  locked = true;
                  repeating = true;
                }
              ];
            }
            {
              _args = [
                "XF86AudioMicMute"
                (toLua ''
                  hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")
                '')
                {
                  locked = true;
                  repeating = true;
                }
              ];
            }
            # LCD Brightness controls:
            {
              _args = [
                "XF86MonBrightnessUp"
                (toLua ''
                  hl.dsp.exec_cmd("${pkgs.brightnessctl}/bin/brightnessctl -e4 -n2 set 5%+")
                '')
                {
                  locked = true;
                  repeating = true;
                }
              ];
            }
            {
              _args = [
                "XF86MonBrightnessDown"
                (toLua ''
                  hl.dsp.exec_cmd("${pkgs.brightnessctl}/bin/brightnessctl -e4 -n2 set 5%-")
                '')
                {
                  locked = true;
                  repeating = true;
                }
              ];
            }
            # Music Player controls (must be compatible with Playerctl)
            {
              _args = [
                "XF86AudioNext"
                (toLua ''
                  hl.dsp.exec_cmd("${pkgs.playerctl}/bin/playerctl next")
                '')
                {
                  locked = true;
                }
              ];
            }
            {
              _args = [
                "XF86AudioPrev"
                (toLua ''
                  hl.dsp.exec_cmd("${pkgs.playerctl}/bin/playerctl previous")
                '')
                {
                  locked = true;
                }
              ];
            }
            {
              _args = [
                "XF86AudioPause"
                (toLua ''
                  hl.dsp.exec_cmd("${pkgs.playerctl}/bin/playerctl play-pause")
                '')
                {
                  locked = true;
                }
              ];
            }
            {
              _args = [
                "XF86AudioPlay"
                (toLua ''
                  hl.dsp.exec_cmd("${pkgs.playerctl}/bin/playerctl play-pause")
                '')
                {
                  locked = true;
                }
              ];
            }
          ]
          ++
            # Focus:

            [
              {
                _args = [
                  "SUPER + left"
                  (toLua ''
                    hl.dsp.focus({ direction = "left" })
                  '')
                ];
              }
              {
                _args = [
                  "SUPER + right"
                  (toLua ''
                    hl.dsp.focus({ direction = "right" })
                  '')
                ];
              }
              {
                _args = [
                  "SUPER + up"
                  (toLua ''
                    hl.dsp.focus({ direction = "up" })
                  '')
                ];
              }
              {
                _args = [
                  "SUPER + down"
                  (toLua ''
                    hl.dsp.focus({ direction = "down" })
                  '')
                ];
              }
            ]
          ++
            # Move:
            [
              {
                _args = [
                  "SUPER + SHIFT + left"
                  (toLua ''
                    hl.dsp.window.move({ direction = "left" })
                  '')
                ];
              }
              {
                _args = [
                  "SUPER + SHIFT + right"
                  (toLua ''
                    hl.dsp.window.move({ direction = "right" })
                  '')
                ];
              }
              {
                _args = [
                  "SUPER + SHIFT + up"
                  (toLua ''
                    hl.dsp.window.move({ direction = "up" })
                  '')
                ];
              }
              {
                _args = [
                  "SUPER + SHIFT + down"
                  (toLua ''
                    hl.dsp.window.move({ direction = "down" })
                  '')
                ];
              }
            ]
          ++
            # Resize:
            [
              {
                _args = [
                  "SUPER + ALT + left"
                  (toLua ''
                    hl.dsp.window.resize({
                      x = -5,
                      y = 0,
                      relative = true
                    })
                  '')
                  {
                    locked = true;
                    repeating = true;
                  }
                ];
              }
              {
                _args = [
                  "SUPER + ALT + right"
                  (toLua ''
                    hl.dsp.window.resize({
                      x = 5,
                      y = 0,
                      relative = true
                    })
                  '')
                  {
                    locked = true;
                    repeating = true;
                  }
                ];
              }
              {
                _args = [
                  "SUPER + ALT + up"
                  (toLua ''
                    hl.dsp.window.resize({
                      x = 0,
                      y = 5,
                      relative = true
                    })
                  '')
                  {
                    locked = true;
                    repeating = true;
                  }
                ];
              }
              {
                _args = [
                  "SUPER + ALT + down"
                  (toLua ''
                    hl.dsp.window.resize({
                      x = 0,
                      y = -5,
                      relative = true
                    })
                  '')
                  {
                    locked = true;
                    repeating = true;
                  }
                ];
              }
            ]
          # Move active window to another workspace:
          ++ (map
            (i: {
              _args = [
                "SUPER + SHIFT + ${toString i}"
                (toLua ''
                  hl.dsp.window.move({
                    workspace = ${toString i},
                    follow = false
                  })
                '')
              ];
            })
            [
              1
              2
              3
              4
              5
              6
              7
              8
              9
              0
            ]
          ) # Move to another workspace:
          ++ (map
            (i: {
              _args = [
                "SUPER + ${toString i}"
                (toLua ''
                  hl.dsp.focus({
                    workspace = ${toString i},
                  })
                '')
              ];
            })
            [
              1
              2
              3
              4
              5
              6
              7
              8
              9
              0
            ]
          );
          on = {
            _args = [
              "hyprland.start"
              (lib.generators.mkLuaInline ''
                function()
                  hl.exec_cmd("systemctl --user start waybar.service")
                  hl.exec_cmd("systemctl --user start hyprpaper.service")
                end
              '')
            ];
          };
        };
      };
    };
}
