{ pkgs, ... }@inputs:
{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 36;
        output = [
          "eDP-1"
          "HDMI-A-1"
        ];
        modules-left = [
          "user"
          "backlight"
          "pulseaudio"
          "network"
          "bluetooth"
          "tray"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "cpu"
          "temperature"
          "memory"
          "disk"
          "battery"
          "clock"
        ];
        user = {
          icon = true;
          avatar = "~/Pictures/jakku-profile.png";
          height = 64;
          width = 64;
          format = " {user} ";
        };
        clock = {
          format = " 󰃰 {:%d-%m-%y %H:%M} ";
          tooltip = false;
        };
        battery = {
          interval = 1;
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = " {icon} {capacity}% ";
          "format-charging" = " 󱊥 {capacity}% ";
          "format-plugged" = " 󰚥 {capacity}% ";
          "format-icons" = [
            "󰂎 "
            "󱊡 "
            "󱊢 "
            "󱊣 "
          ];
        };
        network = {
          interval = 1;
          "format-wifi" = " 󰀂 {essid}  {bandwidthDownBytes}  {bandwidthUpBytes} ";
          "format-ethernet" = " 󰌘 {essid}  {bandwidthDownBytes}  {bandwidthUpBytes} ";
          "format-disconnect" = " 󰌙 {ifname}  {bandwidthDownBytes}  {bandwidthUpBytes} ";
          "format-linked" = " 󰌗 {ifname}: {ipaddr}/{cidr}  {bandwidthDownBytes}  {bandwidthUpBytes} ";

        };
        tray = {
          "icon-size" = 18;
          spacing = 6;
        };
        cpu = {
          interval = 1;
          format = "  {usage}% ";
        };
        memory = {
          interval = 1;
          format = "  {used}GiB/{total}GiB ";
        };
        temperature = {
          interval = 1;
          format = "  {temperatureC}°C ";
        };
        "hyprland/workspaces" = {
          format = "{icon}";
          "format-icons" = {
            "1" = "   ";
            "2" = " 󰈹  ";
            "3" = " 󰨡  ";
            "4" = " 󰕼  ";
            "5" = " 󰓓  ";
            "6" = "   ";
            "7" = "   ";
            "8" = "   ";
            "9" = " 󱄅  ";
            "0" = " 󰢻  ";
            #"active" = " ";
          };
        };
        backlight = {
          format = "  {percent} ";
          interval = 5;
          device = "intel_backlight";
          #on-scroll-up = "backlight_delta /sys/class/backlight/intel_backlight/brightness up 50";
          #on-scroll-down = "backlight_delta /sys/class/backlight/intel_backlight/brightness down 50";
        };
        pulseaudio = {
          format = " 󰕾 {volume} ";
        };
        disk = {
          interval = 1;
          format = " 󰋊 {used}/{total} ";
        };
        bluetooth = {
          format = " 󰂯 {status} ";
        };
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: CascadiaCode;
        font-size: 12pt;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
        color: white;
      }

      #workspaces {
      	background-color: #24283b;
      	margin: 5px;
      	border-radius: 5px;
      }
      #workspaces button {
        padding: 5px;
        color: #c0caf5;
      }

      #workspaces button.focused {
        color: #24283b;
        background-color: #7aa2f7;
        border-radius: 5px;
      }

      #workspaces button:hover {
      	background-color: #7dcfff;
      	color: #24283b;
      	border-radius: 5px;
      }

      #tray, #clock, #battery, #pulseaudio, #backlight, #network, #cpu, #disk, #memory, #temperature, #bluetooth, #user {
      	background-color: #24283b;
        border-radius: 5px;
        margin: 5px;
      }

      #tray {
        color: #7dcfff;
      }

      #custom-date {
      	color: #7dcfff;
      }

      #clock {
          color: #b48ead;
      }

      #battery {
          color: #9ece6a;
      }

      #battery.charging {
          color: #9ece6a;
      }

      #battery.warning:not(.charging) {
          background-color: #f7768e;
          color: #24283b;
      }
      #disk {
          color: #9ece6a;
      }

      #network {
      	color: #f7768e;
      }

      #pulseaudio {
      	color: #e0af68;
      }

      #backlight {
        color: #e0af68;
      }
      #cpu {
        color: #e0af68;
      }
      #memory {
      	color: #f7768e;
      }
    '';
  };
}
