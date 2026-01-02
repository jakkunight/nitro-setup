{lib, ...}: let
  moduleName = "desktop/nightmare/waybar";
in {
  flake.modules = {
    homeManager.${moduleName} = {
      config,
      pkgs,
      ...
    }: {
      programs.waybar.enable = true;
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
                "notification" = "󱅫";
                "none" = "󰂚";
                "dnd-notification" = "󰵙";
                "dnd-none" = "󱏧";
                "inhibited-notification" = "󱅫";
                "inhibited-none" = "󰂚";
                "dnd-inhibited-notification" = "󰵙";
                "dnd-inhibited-none" = "󱏧";
              };
              "return-type" = "json";
              "exec-if" = "which swaync-client";
              "exec" = "${pkgs.swaynotificationcenter}/bin/swaync-client -swb";
              "on-click" = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
              "on-click-right" = "${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw";
              "escape" = true;
            };
          };
        };
        style = lib.mkAfter ''
          #workspaces button {
            font-size: 2rem;
            color: @base03;
          }
          #workspaces button.active {
            font-size: 2rem;
            color: @base0D;
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
      stylix.targets.waybar = {
        font = "serif";
      };
      wayland.windowManager.hyprland.settings = {
        exec-once = [
          "systemctl --user enable --now waybar"
        ];
      };
    };
  };
}
