let
  feature = "nightmare-waybar";
in
{ inputs, self, ... }: {
  flake.modules.homeManager.${feature} = { pkgs, lib, ... }: {
    programs.waybar.settings = [
      {
        name = "main";
        layer = "top";
        position = "top";
        height = 36;
        spacing = 8;
        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "network"
          "tray"
          "custom/notification"
        ];
        # Modules:
        "hyprland/window" = {
          "format" = "  {title}";
          "max-length" = 16;
        };
        "hyprland/workspaces" = {
          # "move-to-monitor" = true;
          # "persistent-workspaces" = {

          # };
          "format" = "{icon}";
          "format-icons" = {
            "1" = "";
            "2" = "󰈹";
            "3" = "󰨡";
            "4" = "󰕼";
            "5" = "󰓓";
            "6" = "";
            "7" = "";
            "default" = "";
          };
        };
        "tray" = {
          "icon-size" = 20;
          "spacing" = 8;
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
              "󰈁"
              "󰈂"
            ];
            "linked" = [
              "󰌚"
            ];
            "disconnected" = [
              "󰌙"
            ];
          };
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
      }
    ];
  };
}
