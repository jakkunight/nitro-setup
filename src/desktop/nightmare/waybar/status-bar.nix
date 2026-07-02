let
  feature = "nightmare-waybar";
in
{ inputs, self, ... }: {
  flake.modules.homeManager.${feature} = { pkgs, lib, ... }: {
    programs.waybar.settings = [
      {
        name = "status";
        height = 36;
        layer = "top";
        position = "bottom";
        modules-left = [
          "user"
        ];
        modules-center = [
          "cpu"
          "memory"
          "disk"
          "temperature"
          "battery"
          "backlight"
          "pulseaudio"
          "systemd-failed-unit"
        ];
        modules-right = [
          "hyprland/language"
          "keyboard-state"
        ];
        "user" = {
          "format" = "{user}";
          "icon" = true;
        };
        "hyprland/language" = {
          "format-en" = "🇺🇸";
          # "format-es" = "🇪🇸";
          "format-jp" = "🇯🇵";
          "format-es" = "🇵🇾";
          # "format-cn" = "🇨🇳";
          "format-cn" = "🇹🇼";
        };
        "keyboard-state" = {
          "capslock" = true;
          "numlock" = true;
          "format" = "{name} {icon}";
          "format-icons" = {
            "locked" = " 󰌾 ";
            "unlocked" = " 󰍀 ";
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
          "format" = " {used:0.1f}GiB";
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
          "bat" = "BAT1";
          # "adapter" = "/sys/class/power_supply/ACAD";
          "adapter" = "ACAD";
        };
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
      }
    ];
  };
}
