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
      terminal_app = "kitty";
      # filemanager_app = "nemo";
      app_launcher = "wofi";
    in
    {
      imports = with self.modules.homeManager; [
        hyprland
        # kitty
        # foot
        # zen-browser
        # waybar
        # hyprwall
        # swaync
        # ashell
        # hyprlock
        # hypridle
        # zsh
        # nushell
        # qutebrowser
        # remmina
        # wofi
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
              gaps_in = 0;
              gaps_out = 0;
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
              rounding = 0;
              rounding_power = 0.0;
              blur = {
                enabled = false;
                size = 8;
                passes = 2;
                ignore_opacity = true;
                new_optimizations = true;
                xray = true;
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
              position = "auto";
              scale = 1;
            }
            {
              output = "";
              mode = "preferred";
              position = "auto";
              scale = 1;
            }
          ];
          # ---- BINDS ----
          # In order to make my binds a bit better? I'll go with the
          # AoE2:DE keyboard layout as follows:
          # - Exit submap => ESCAPE (for all submaps)
          # - SUPER + RETURN => Open terminal
          # - SUPER + SPACE => Open app launcher
          # - SUPER + Q => Quit mode
          #   - Q => Kill active window
          #   - W => Quit active window
          #   - E => Exit Hyprland session
          # - SUPER + W => Window focus mode
          #   - H => Focus the left window
          #   - L => Focus the right window
          #   - K => Focus the up window
          #   - J => Focus the down window
          # - SUPER + E => Window move mode
          #   - H => Move the window left
          #   - L => Move the window right
          #   - K => Move the window up
          #   - J => Move the window down
          # - SUPER + R => Window resize mode
          #   - H => Resize the window left
          #   - L => Resize the window right
          #   - K => Resize the window up
          #   - J => Resize the window down
          # - SUPER + T => Window type mode
          #   - Q => Toggle float
          #   - W => Toggle fullscreen
          # - SUPER + A => Quick app mode
          #   - Q => Open web browser
          #   - W => Open network manager
          #   - E => Open file manager
          #   - R => Open music player
          define_submap = [
            # Define submap for Quit mode (SUPER + Q)
            {
              _args = [
                "quit"
                "reset"
                (lib.generators.mkLuaInline ''
                  function()
                    -- Kill active window
                    hl.bind("q", function()
                      hl.dsp.window.kill()
                    end)

                    -- Quit active window
                    hl.bind("w", function()
                      hl.dsp.window.close()
                    end)

                    -- Exit Hyprland session
                    hl.bind("e", hl.dsp.exit())

                    -- Lock screen
                    hl.bind("r", function()
                      hl.dsp.exec_cmd("${pkgs.hyprlock}/bin/hyprlock --grace 0")
                    end)
                  end
                '')
              ];
            }
            # Define submap for Window focus mode (SUPER + W)
            {
              _args = [
                "focus"
                "reset"
                (lib.generators.mkLuaInline ''
                  function()
                    -- Focus left window
                    hl.bind("h", function()
                      hl.dsp.focus({ direction = "l" })
                    end)

                    -- Focus right window
                    hl.bind("l", function()
                      hl.dsp.focus({ direction = "r" })
                      hl.dsp.submap("reset")
                    end)

                    -- Focus up window
                    hl.bind("k", function()
                      hl.dsp.focus({ direction = "u" })
                      hl.dsp.submap("reset")
                    end)

                    -- Focus down window
                    hl.bind("j", function()
                      hl.dsp.focus({ direction = "r" })
                      hl.dsp.submap("reset")
                    end)
                  end
                '')
              ];
            }
            # Define submap for Window move mode (SUPER + E)
            {
              _args = [
                "move"
                (lib.generators.mkLuaInline ''
                  function()
                    -- Exit submap
                    hl.bind("escape", hl.dsp.submap("reset"))

                    -- move left window
                    hl.bind("h", function()
                      hl.dsp.window.move({ direction = "l" })
                    end)

                    -- move right window
                    hl.bind("l", function()
                      hl.dsp.window.move({ direction = "r" })
                    end)

                    -- move up window
                    hl.bind("k", function()
                      hl.dsp.window.move({ direction = "u" })
                    end)

                    -- move down window
                    hl.bind("j", function()
                      hl.dsp.window.move({ direction = "r" })
                    end)

                  end
                '')
              ];
            }
            # Define submap for Window resize mode (SUPER + R)
            {
              _args = [
                "resize"
                (lib.generators.mkLuaInline ''
                  function()
                    -- Exit submap
                    hl.bind("escape", hl.dsp.submap("reset"))

                    -- Resize window left (shrink width)
                    hl.bind("h", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })

                    -- Resize window right (expand width)
                    hl.bind("l", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })

                    -- Resize window up (shrink height)
                    hl.bind("k", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })

                    -- Resize window down (expand height)
                    hl.bind("j", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
                  end
                '')
              ];
            }
            # Define submap for Window type mode (SUPER + T)
            {
              _args = [
                "window-type"
                (lib.generators.mkLuaInline ''
                  function()
                    -- Exit submap
                    hl.bind("escape", hl.dsp.submap("reset"))

                    -- Toggle float
                    hl.bind("q", function()
                      hl.dsp.window.float()
                      hl.dsp.submap("reset")
                    end)

                    -- Toggle fullscreen
                    hl.bind("w", function()
                      hl.dsp.window.fullscreen()
                      hl.dsp.submap("reset")
                    end)
                  end
                '')
              ];
            }
            # Define submap for Quick app mode (SUPER + A)
            {
              _args = [
                "quick-app"
                (lib.generators.mkLuaInline ''
                  function()
                    -- Exit submap
                    hl.bind("escape", hl.dsp.submap("reset"))

                    -- Open web browser (Zen Browser)
                    hl.bind("q", function()
                      hl.dsp.exec_cmd("${
                        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.twilight
                      }/bin/zen-twilight")
                      hl.dsp.submap("reset")
                    end)

                    -- Open network manager (Impala)
                    hl.bind("w", function()
                      hl.dsp.exec_cmd("${pkgs.kitty}/bin/kitty sh -c '${pkgs.impala}/bin/impala'")
                      hl.dsp.submap("reset")
                    end)

                    -- Open file manager (Yazi)
                    hl.bind("e", function()
                      hl.dsp.exec_cmd("${pkgs.kitty}/bin/kitty sh -c '${pkgs.nemo}/bin/nemo'")
                      hl.dsp.submap("reset")
                    end)

                    -- Open music player (RMPC)
                    hl.bind("r", function()
                      hl.dsp.exec_cmd("${pkgs.kitty}/bin/kitty sh -c '${pkgs.rmpc}/bin/rmpc --address 127.0.0.1:6600'")
                      hl.dsp.submap("reset")
                    end)
                  end
                '')
              ];
            }
          ];
          bind = [
            # Open terminal (Kitty)
            {
              _args = [
                "SUPER + RETURN"
                (lib.generators.mkLuaInline ''
                  hl.dsp.exec_cmd("${pkgs.kitty}/bin/kitty")
                '')
              ];
            }
            # Open app launcher (Wofi)
            {
              _args = [
                "SUPER + SPACE"
                (lib.generators.mkLuaInline ''
                  hl.dsp.exec_cmd("${pkgs.wofi}/bin/wofi --show drun")
                '')
              ];
            }
            # Enter Quit mode
            {
              _args = [
                "SUPER + Q"
                (lib.generators.mkLuaInline ''
                  hl.dsp.submap("quit", "reset")
                '')
              ];
            }
            # Enter Window focus mode
            {
              _args = [
                "SUPER + W"
                (lib.generators.mkLuaInline ''
                  hl.dsp.submap("focus", "reset")
                '')
              ];
            }
            # Enter Window move mode
            {
              _args = [
                "SUPER + E"
                (lib.generators.mkLuaInline ''
                  hl.dsp.submap("move")
                '')
              ];
            }
            # Enter Window resize mode
            {
              _args = [
                "SUPER + R"
                (lib.generators.mkLuaInline ''
                  hl.dsp.submap("resize")
                '')
              ];
            }
            # Enter Window type mode
            {
              _args = [
                "SUPER + T"
                (lib.generators.mkLuaInline ''
                  hl.dsp.submap("window-type", "reset")
                '')
              ];
            }
            # Enter Quick app mode
            {
              _args = [
                "SUPER + A"
                (lib.generators.mkLuaInline ''
                  hl.dsp.submap("quick-app", "reset")
                '')
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
