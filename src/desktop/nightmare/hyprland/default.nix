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
              snap = { };
            };
            decoration = {
              rounding = 0;
              rounding_power = 0.0;
              blur = {
                enabled = true;
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
                enabled = true;
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
          moitor = [
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
          # - SUPER + T => Quick app mode
          #   - Q => Open web browser
          #   - W => Open network manager
          #   - E => Open file manager
          #   - R => Open music player
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
                  hl.dsp.submap("quit")
                '')
              ];
            }

            # Enter Window focus mode
            {
              _args = [
                "SUPER + W"
                (lib.generators.mkLuaInline ''
                  hl.dsp.submap("focus")
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
                  hl.dsp.submap("window-type")
                '')
              ];
            }

            # Enter Quick app mode
            {
              _args = [
                "SUPER + A"
                (lib.generators.mkLuaInline ''
                  hl.dsp.submap("quick-app")
                '')
              ];
            }

          ]
          # Move active window to another workspace:
          ++ (map
            (i: {
              _args = [
                "SUPER + SHIFT + ${i}"
                (toLua ''
                  hl.dsp.window.move({
                    workspace = ${i},
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
                "SUPER + ${i}"
                (toLua ''
                  hl.dsp.focus({
                    workspace = ${i},
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
          define_submap = [
            # Define submap for Quit mode (SUPER + Q)
            {
              _args = [
                "quit"
                (lib.generators.mkLuaInline ''
                  function()
                    -- Exit submap
                    hl.bind("escape", hl.dsp.submap("reset"))

                    -- Kill active window
                    hl.bind("q", hl.dsp.window.kill())

                    -- Quit active window
                    hl.bind("w", hl.dsp.window.close())

                    -- Exit Hyprland session
                    hl.bind("e", hl.dsp.exit())
                  end
                '')
              ];
            }
            # Define submap for Window focus mode (SUPER + W)
            {
              _args = [
                "focus"
                (lib.generators.mkLuaInline ''
                  function()
                    -- Exit submap
                    hl.bind("escape", hl.dsp.submap("reset"))

                    -- Focus left window
                    hl.bind("h", hl.dsp.window.focus({ direction = "l" }))

                    -- Focus right window
                    hl.bind("l", hl.dsp.window.focus({ direction = "r" }))

                    -- Focus up window
                    hl.bind("k", hl.dsp.window.focus({ direction = "u" }))

                    -- Focus down window
                    hl.bind("j", hl.dsp.window.focus({ direction = "d" }))
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

                    -- Move window left
                    hl.bind("h", hl.dsp.window.move({ direction = "l" }))

                    -- Move window right
                    hl.bind("l", hl.dsp.window.move({ direction = "r" }))

                    -- Move window up
                    hl.bind("k", hl.dsp.window.move({ direction = "u" }))

                    -- Move window down
                    hl.bind("j", hl.dsp.window.move({ direction = "d" }))
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
                    hl.bind("q", hl.dsp.window.float())

                    -- Toggle fullscreen
                    hl.bind("w", hl.dsp.window.fullscreen())
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
                    hl.bind("q", hl.dsp.exec_cmd("${
                      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-twilight
                    }/bin/zen-twilight"))

                    -- Open network manager (Impala)
                    hl.bind("w", hl.dsp.exec_cmd("${pkgs.impala}/bin/impala"))

                    -- Open file manager (Yazi)
                    hl.bind("e", hl.dsp.exec_cmd("${pkgs.nemo}/bin/nemo"))

                    -- Open music player (RMPC)
                    hl.bind("r", hl.dsp.exec_cmd("${pkgs.rmpc}/bin/rmpc --address 127.0.0.1:6600"))
                  end
                '')
              ];
            }
          ];
        };
      };
    };
}
