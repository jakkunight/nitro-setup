# Waybar config:
{ config, pkgs, lib, ... }:
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
            #"active" = " ";
          };
        };
        backlight = {
          format = "  {percent} ";
          interval = 5;
          device = "intel_backlight";
          "on-scroll-up" = "brightnessctl set 1%+";
          "on-scroll-down" = "brightnessctl set 1%-";
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
    style = toString (builtins.readFile ./style.css);
  };
}
