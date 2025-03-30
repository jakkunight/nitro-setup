# Waybar config:
{ config, pkgs, lib, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 36;
        margin-left = 10;
        margin-right = 10;
        margin-top = 10;
        padding = 5;
        output = [
          "eDP-1"
          "HDMI-A-1"
        ];
        modules-left = [
          "user"
          "tray"
          "hyprland/workspaces"
        ];
        modules-center = [
        ];
        modules-right = [
          "network"
          "bluetooth"
          "cpu"
          "temperature"
          "memory"
          "disk"
          "pulseaudio"
          "backlight"
          "battery"
          "custom/clock"
        ];
        network = {
          interval = 1;
          "format-wifi" = " 󰀂 {essid}  {bandwidthDownBytes}  {bandwidthUpBytes} ";
          "format-ethernet" = " 󰌘 {essid}  {bandwidthDownBytes}  {bandwidthUpBytes} ";
          "format-disconnect" = " 󰌙 {ifname}  {bandwidthDownBytes}  {bandwidthUpBytes} ";
          "format-linked" = " 󰌗 {ifname}: {ipaddr}/{cidr}  {bandwidthDownBytes}  {bandwidthUpBytes} ";
        };
        cpu = {
          interval = 1;
          format = "  {usage}% ";
        };
        memory = {
          interval = 1;
          format = "  {used}GiB ";
        };
        temperature = {
          interval = 1;
          format = "  {temperatureC}°C ";
        };
        disk = {
          interval = 1;
          format = " 󰋊 {used}";
        };
        bluetooth = {
          format = " 󰂯 {status}";
        };
        user = {
          icon = true;
          avatar = "$HOME/.face";
          height = 36;
          width = 36;
          format = "{user}";
        };
        "custom/clock" = {
          format = "󰃰 {}";
          exec = "date +'%A, %d-%m-%Y %H:%M' ";
          tooltip = false;
          interval = 1;
        };
        # clock = {
        #   format = " 󰃰 {:L%A %d-%m-%y %R} ";
        #   locale = "es_PY.utf8";
        #   timezone = "America/Asuncion";
        #   interval = 1;
        #   tooltip = true;
        #   tooltip-format = "<tt><big>{calendar}</big></tt>";
        #   calendar = {
        #     mode = "month";
        #     format = {
        #       months = "<span color='#ffead3'><b>{}</b></span>";
        #       days = "<span color='#ecc6d9'><b>{}</b></span>";
        #       weeks = "<span color='#99ffdd'><b>W{}</b></span>";
        #       weekdays = "<span color='#ffcc66'><b>{}</b></span>";
        #       today = "<span color='#ff6699'><b><u>{}</u></b></span>";
        #     };
        #   };
        #   actions = {
        #     on-scroll-up = "tz_up";
        #     on-scroll-down = "tz_down";
        #   };
        # };
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
        tray = {
          "icon-size" = 18;
          spacing = 6;
        };
        "hyprland/workspaces" = {
          format = "{icon}";
          persistent-workspaces = {
            "*" = 6;
          };
          "format-icons" = {
            "1" = "  ";
            "2" = " 󰈹 ";
            "3" = " 󰨡 ";
            "4" = " 󰕼 ";
            "5" = " 󰓓 ";
            "6" = "  ";
            "7" = "  ";
            "8" = "  ";
            "9" = " 󱄅 ";
            "0" = " 󰢻 ";
          };
        };
        backlight = {
          format = "  {percent}";
          interval = 5;
          device = "intel_backlight";
          "on-scroll-up" = "brightnessctl set 1%+";
          "on-scroll-down" = "brightnessctl set 1%-";
        };
        pulseaudio = {
          format = " 󰕾 {volume}";
        };
      };
    };
    style = toString (builtins.readFile ./style.css);
  };
}
