{ config, lib, pkgs, inputs, ... }:
{
# Hypridle:
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_command = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 1200;
          on-timeout = "pidof hyprlock || hyprlock";
        }
      ];
    };
  };
}
