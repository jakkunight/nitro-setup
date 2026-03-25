let
  feature = "nightmare-desktop";
in
{
  self,
  inputs,
  ...
}:
{
  flake.modules = {
    nixos.${feature} =
      {
        pkgs,
        lib,
        config,
        ...
      }:
      {
        imports = with self.modules.nixos; [
          hyprland
          hyprland-nvidia
          kitty
          foot
        ];

      };
    homeManager.${feature} =
      {
        pkgs,
        lib,
        config,
        ...
      }:
      {
        imports = with self.modules.homeManager; [
          hyprland
          kitty
          foot
          zen-browser
          waybar
          hyprwall
          swaync
          # ashell
          hyprlock
          hypridle
          zsh
          nushell
          qutebrowser
          remmina
          wofi
        ];

        programs.zsh.initContent = lib.mkOrder 1200 ''
          clear
          ${pkgs.fastfetch}/bin/fastfetch
          echo "Welcome back, $USER! (^.^)"
        '';

        services.hypridle = {
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

        programs.hyprlock =
          let
            profile = "${config.home.homeDirectory}/.face";
            rgba = color: alpha: "rgba(${color}${alpha})";
            rgb = color: "rgba(${color})";
          in
          {
            settings = {
              animations = {
                enabled = true;
                fade_in = {
                  duration = 300;
                  bezier = "easeOutQuint";
                };
                fade_out = {
                  duration = 300;
                  bezier = "easeOutQuint";
                };
              };
              # User profile
              image = {
                path = "${profile}";
                size = "130";
                rounding = "-1";
                position = "0, 40";
                halign = "center";
                valign = "center";
              };
              shape = [
                # User box
                {
                  xray = "false"; # if true, make a "hole" in the background (rectangle of specified size, no rotation)
                  size = "300, 60";
                  rounding = "-1";
                  color = rgba config.lib.stylix.colors.base00 "70";
                  position = "0, -130";
                  halign = "center";
                  valign = "center";
                }
              ];
              label = [
                # Date
                {
                  text = "cmd[update:1000] echo -e \"$(date +\"%A, %B %d\")\"";
                  font_color = rgb config.lib.stylix.colors.base06;
                  font_size = "25";
                  position = "0, 350";
                  halign = "center";
                  valign = "center";
                }
                # Time
                {
                  text = "cmd[update:1000] echo -e \"$(date +\"%I:%M\")\"";
                  font_color = rgb config.lib.stylix.colors.base06;
                  font_size = "120";
                  position = "0, 250";
                  halign = "center";
                  valign = "center";
                }
                # User label
                {
                  text = "    $USER";
                  font_color = rgb config.lib.stylix.colors.base06;
                  font_size = "18";
                  position = "0, -130";
                  halign = "center";
                  valign = "center";
                }
              ];
              input-field = {
                size = lib.mkForce "300, 60";
                position = lib.mkForce "0, -210";
                halign = "center";
                valign = "center";
              };
            };

          };

        programs.ashell.settings =
          let
            inherit (config.lib.stylix.colors.withHashtag)
              base00
              base01
              base05
              base08
              base09
              base0A
              base0B
              base0C
              base0D
              base0E
              base0F
              ;
          in
          {
            modules = {
              left = [
                "SystemInfo"
                "MediaPlayer"
              ];
              center = [
                "Workspaces"
              ];
              right = [
                "Tray"
                [
                  "Clock"
                  "Privacy"
                  "Settings"
                ]
              ];
            };
            appearance = lib.mkAfter {
              style = "Islands";
              scale_factor = 1.3;
              font_name = lib.mkForce "${config.stylix.fonts.monospace.name}";
              workspace_colors = lib.mkForce [
                base0D
                base0C
                base0E
              ];
            };
          };
        wayland.windowManager.hyprland = {
          settings = {
            env = [
            ];
            input.kb_layout = "latam";
            input.follow_mouse = 0;
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
              "$mod, Return, exec, ${pkgs.foot}/bin/foot"
              # "$mod, Return, exec, ${pkgs.kitty}/bin/kitty"
              # "$mod, Return, exec, ${pkgs.ghostty}/bin/ghostty"
              "$mod, D, exec, ${pkgs.wofi}/bin/wofi --show drun"
              # "$mod, D, exec, ${pkgs.hyprlauncher}/bin/hyprlauncher"
              "$mod, A, exec, ${
                inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.twilight
              }/bin/zen-twilight"
              "$mod, R, exec, ${pkgs.qutebrowser}/bin/qutebrowser"
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

              # Focus controls:
              # hyprEasymotions:

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
            ]
            ++ (
              # Navigation:
              # workspaces
              # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
              builtins.concatLists (
                builtins.genList (
                  i:
                  let
                    ws = i + 1;
                  in
                  [
                    "$mod, code:1${toString i}, workspace, ${toString ws}"
                    "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                  ]
                ) 9
              )
            );
            monitor = [
              "eDP-1,highres,auto,1"
              ",highres,auto,1"
            ];
            exec-once = [
              "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
              # "hyprctl plugin load ${
              # inputs.hyprglass.packages.${pkgs.stdenv.hostPlatform.system}.hyprglass
              # }/lib/hyprglass.so"
              # "hyprctl plugin load ${
              #   inputs.hypr-darkwindow.packages.${pkgs.stdenv.hostPlatform.system}.Hypr-DarkWindow
              # }/lib/libHypr-DarkWindow.so"
              # "hyprctl plugin load ${pkgs.hyprlandPlugins.hyprbars}/lib/libhyprbarsso."
              "systemctl --user restart hyprwall"
              # "hyprctl plugin load ${
              #   inputs.hyprland-easymotion.packages.${pkgs.stdenv.hostPlatform.system}.hyprland-easymotion
              # }/lib/hypreasymotion.so"
            ];
            # plugin = {
            #   hyprglass = {
            #     default_theme = "dark";
            #     default_preset = "glass";
            #   };
            # };
            # Hyprbars:
            # hyprbars-button = "bgcolor, size, icon, on-click, fgcolor";
            general = {
              layout = "master";
              gaps_in = 0;
              gaps_out = 0;
              border_size = 2;
              resize_on_border = true;
            };
            master = {
              mfact = 0.50;
              orientation = "left";
              new_status = "slave";
              new_on_top = false;
              smart_resizing = true;
              drop_at_cursor = false;
            };
            # Apply blur for Wofi and Waybar:
            layerrule = [
              "match:namespace waybar, blur on"
              "match:namespace waybar, blur_popups on"
              "match:namespace wofi, blur on"
              "match:namespace wofi, blur_popups on"
              "match:namespace wofi, xray 1"
              "match:namespace wofi, dim_around on"
            ];
            # Hypr-DarkWindow:
            windowrule = [
              # Transparent apps:
              # "darkwindow:shade chromakey targetOpacity=0.8, match:class .*"
            ];
            # Decorations:
            decoration = {
              rounding = 0;
              rounding_power = 0;
              # Transparency:
              active_opacity = lib.mkForce 1.0;
              inactive_opacity = lib.mkForce 0.90;

              # Shadow:
              shadow = {
                enabled = false;
                range = 25;
                render_power = 3;
              };
              # Blur:
              blur = {
                enabled = false;
                size = 7;
                passes = 3;
                new_optimizations = true;
                ignore_opacity = true;
                xray = false;
                noise = 0.1;
                vibrancy = 1.0;
                brightness = 1.0;
                contrast = 1.1;
                popups = true;
              };
            };
          };
        };
        programs.waybar = {
          settings = {
            main-bar = {
              name = "main";
              layer = "top";
              position = "top";
              modules-left = [
                "network"
                "cpu"
                "temperature"
                "memory"
                "disk"
              ];
              modules-center = [
                "hyprland/workspaces"
              ];
              modules-right = [
                "tray"
                "pulseaudio"
                "backlight"
                "battery"
                "clock"
                "custom/notification"
              ];
              # Modules:
              "backlight" = {
                "interval" = 5;
                "format" = "{icon} {percent}%";
                "format-icons" = [
                  "󰛩"
                  "󱩎"
                  "󱩏"
                  "󱩐"
                  "󱩑"
                  "󱩒"
                  "󱩓"
                  "󱩓"
                  "󱩔"
                  "󱩕"
                  "󱩖"
                  "󰛨"
                ];
              };
              "pulseaudio" = {
                "interval" = 5;
                "format" = "{icon} {volume}%";
                "format-muted" = "";
                "format-icons" = [
                  ""
                  ""
                  ""
                ];
              };
              "tray" = {
                "spacing" = 10;
              };
              "hyprland/workspaces" = {
                "persistent-workspaces" = {
                  "*" = 6;
                };
                "format" = "{icon}";
                "format-icons" = {
                  "1" = "󱄅";
                  "2" = "󰈹";
                  "3" = "󰨡";
                  "4" = "󰕼";
                  "5" = "󰓓";
                  "6" = "";
                  "default" = "";
                };
              };
              "network" = {
                "interval" = 1;
                "format-wifi" = "{icon} {essid}  {bandwidthDownBytes}  {bandwidthUpBytes}";
                "format-ethernet" = "{icon}  {bandwidthDownBytes}  {bandwidthUpBytes}";
                "format-disconnected" = "{icon} Disconnected";
                "format-alt" = "{icon} {ipaddr}/{cidr}";
                "tooltip-format" = "{ifname} via {gwaddr}";
                "tooltip-format-wifi" = "{ifname} 󱑽 {frequency}GHz 󰹤 {signaldBm}dB";
                "tooltip-format-ethernet" = "{icon} {ifname}";
                "format-icons" = {
                  "wifi" = [
                    "󰤯"
                    "󰤟"
                    "󰤢"
                    "󰤥"
                    "󰤨"
                  ];
                  "ethernet" = [
                    "󰈂"
                    "󰈁"
                  ];
                  "linked" = [
                    "󰌚"
                  ];
                  "disconnected" = [
                    "󰌙"
                  ];
                };
              };
              "cpu" = {
                "interval" = 1;
                "format" = " {usage}%";
              };
              "temperature" = {
                "interval" = 1;
                "format" = "{icon} {temperatureC}󰔄 ";
                "format-icons" = [
                  ""
                  ""
                  ""
                  ""
                  ""
                ];
              };
              "memory" = {
                "interval" = 1;
                "format" = " {used}GiB";
                "tooltip-format" = "{used}GiB used out of {total}GiB ({percentage}%)";
              };
              "disk" = {
                "interval" = 1;
                "format" = " {used}";
              };
              "battery" = {
                "format" = "{icon} {capacity}%";
                "format-icons" = [
                  "󰂎"
                  "󱊡"
                  "󱊢"
                  "󱊣"
                ];
              };
              "custom/clock" = {
                "format " = "󰃰 {}";
                "exec " = "date +'%A, %d-%m-%Y %H:%M'";
                "tooltip" = true;
                "interval" = 1;
              };
              "clock" = {
                "format" = "󰃰 {:L%A, %d-%m-%Y %H:%M}";
                "interval" = 1;
                "tooltip" = true;
                "tooltip-format" = "<tt><big>{calendar}</big></tt>";
              };
              "custom/notification" = {
                "tooltip" = false;
                "format" = "{icon}";
                "format-icons" = {
                  "notification" = "󱅫 ";
                  "none" = "󰂚";
                  "dnd-notification" = "󰵙 ";
                  "dnd-none" = "󱏧";
                  "inhibited-notification" = "󱅫 ";
                  "inhibited-none" = "󰂚 ";
                  "dnd-inhibited-notification" = "󰵙 ";
                  "dnd-inhibited-none" = "󱏧 ";
                };
                "return-type" = "json";
                "exec-if" = "which swaync-client";
                "exec" = "${pkgs.swaynotificationcenter}/bin/swaync-client -swb";
                "on-click" = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
                "on-click-right" = "${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw";
                "escape" = true;
              };
              "mpris" = {
                "format" = "{player-icon} ";
                "format-paused" = "{status_icon} <i>{dynamic}</i>";
                "on-click-middle" = "${pkgs.playerctl}/bin/playerctl play-pause";
                "on-click" = "${pkgs.playerctl}/bin/playerctl previous";
                "on-click-right" = "${pkgs.playerctl}/bin/playerctl next";
                "player-icons" = {
                  "spotify" = " ";
                  "firefox" = "󰖟 ";
                  "mpv" = "󰐹 ";
                  "mpd" = "󰫔 ";
                  "vlc" = "󰕼 ";
                };
                "max-length" = "30";
              };
            };
          };
          style = lib.mkAfter ''
            window#waybar {
              border-style: solid;
              border-width: 2px;
              border-color: @base0D;
              padding: 2px;
            }
            #workspaces button {
              font-size: 1rem;
              color: @base03;
              box-shadow: none;
            }
            #workspaces button:hover {
              font-size: 1rem;
              color: @base0D;
              border-width: 1px;
              border-color: @base0D;
              background-color: transparent;
            }
            #workspaces button.active {
              font-size: 1rem;
              color: @base0D;
              border-width: 1px;
              border-color: @base0D;
              background-color: transparent;
              box-shadow: none;
            }
            #battery {
              color: @base0B;
            }

            #backlight {
              color: @base0A;
            }
            #pulseaudio {
              color: @base0E;
            }
            #clock {
              color: @base0C;
            }
            #cpu {
              color: @base0A;
            }
            #network {
              color: @base0C;
            }
            #temperature {
              color: @base09;
            }
            #memory {
              color: @base0D;
            }
            #disk {
              color: @base0B;
            }
            #custom-notification {
              color: @base09;
            }
          '';
        };
        programs.wofi = {
          settings = {
            allow_images = true;
          };
          style = lib.mkAfter ''
            * {
              background: transparent;
            }

            #window {
              margin: auto;
              padding: 10px;
            }

            #input {
              padding: 10px;
              margin-bottom: 10px;
            }

            #outer-box {
              padding: 20px;
            }

            #img {
              margin-right: 6px;
            }

            #entry {
              padding: 10px;
            }

            #text {
              margin: 2px;
            }
          '';

        };
        # stylix.targets.waybar = {
        #   font = "serif";
        # };
        stylix.targets.zen-browser.profileNames = [
          "default"
        ];
        programs.zen-browser.profiles."default" = {
          mods = [
            "642854b5-88b4-4c40-b256-e035532109df" # Transparent Zen Mod
          ];
        };
      };
  };
}
