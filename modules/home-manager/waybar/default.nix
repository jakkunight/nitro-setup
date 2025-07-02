{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    settings = {
      main-bar = {
        name = "main";
        layer = "top";
        position = "top";
        modules-left = [
          "backlight"
          "backlight/slider"
          "pulseaudio"
          "pulseaudio/slider"
        ];
        modules-center = [
          "tray"
          "hyprland/workspaces"
        ];
        modules-right = [
          "network"
          "cpu"
          "temperature"
          "memory"
          "disk"
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
        "backlight/slider" = {
          "min" = 0;
          "max" = 100;
          "orientation" = "horizontal";
          "device" = "intel_backlight";
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
        "pulseaudio/slider" = {
          "min" = 0;
          "max" = 100;
          "orientation" = "horizontal";
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
            "notification" = "<sup></sup>";
            "none" = "";
            "dnd-notification" = "<sup></sup>";
            "dnd-none" = "";
            "inhibited-notification" = "<sup></sup>";
            "inhibited-none" = "";
            "dnd-inhibited-notification" = "<sup></sup>";
            "dnd-inhibited-none" = "";
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
    style = ''
      #backlight-slider slider {
        opacity: 0;
        border: none;
        box-shadow: none;
        min-height: 0rem;
        min-width: 0rem;
      }
      #backlight-slider trough {
        border-radius: 5px;
        min-height: 0.2rem;
        min-width: 4rem;
      }
      #backlight-slider highlight {
        border-radius: 5px;
        min-width: 4rem;
        min-height: 0.2rem;
      }
      #pulseaudio-slider slider {
        opacity: 0;
        background-image: none;
        border: none;
        box-shadow: none;
        min-height: 0rem;
        min-width: 0rem;
      }
      #pulseaudio-slider trough {
        border-radius: 5px;
        min-width: 4rem;
        min-height: 0.2rem;
      }
      #pulseaudio-slider highlight {
        border-radius: 5px;
        min-width: 4rem;
        min-height: 0.2rem;
      }
      #workspaces button {
        font-size: 2rem;
      }
      #workspaces button.active {
        font-size: 2rem;
      }
    '';
  };
  stylix.targets.waybar = {
    font = "serif";
  };
}
