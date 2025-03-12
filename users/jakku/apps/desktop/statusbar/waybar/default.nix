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
          "clock"
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
