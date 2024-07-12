{ pkgs, ... }@inputs:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [
          "eDP-1"
          "HDMI-A-1"
        ];
        modules-left = [
          "user"
          "backlight/slider"
          "pulseaudio/slider"
          "mpd"
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
          "bluetooth"
          "network"
          "battery"
          "power-profiles-daemon"
          "clock"
        ];
      };
    };
    style = '''';
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
  };
}
