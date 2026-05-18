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
                "mpd"
                "mpris"
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
                  "none" = "󰂚 ";
                  "dnd-notification" = "󰵙 ";
                  "dnd-none" = "󱏧 ";
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
              "mpd" = {
                "format" = "  ";
                "format-paused" = "  ";
                "format-disconnected" = "  ";
                "format-stopped" = "  ";
                "interval" = 10;
                "on-click" = "${pkgs.mpc}/bin/mpc toggle";
              };
              "mpris" = {
                "interval" = 1;
                "format" = "{player_icon}";
                "format-paused" = "{status_icon}";
                "player-icons" = {
                  "default" = "  ";
                };
                "status-icons" = {
                  "paused" = "  ";
                  "disconnected" = "  ";
                };
                "title-len" = 8;
                "artist-len" = 8;
                "album-len" = 8;
                "position-len" = 8;
                "length-len" = 8;
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
