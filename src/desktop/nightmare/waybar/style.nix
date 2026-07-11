let
  feature = "nightmare-waybar";
in
{ inputs, self, ... }: {
  flake.modules.homeManager.${feature} = { pkgs, lib, ... }: {
    # imports = with self.modules.homeManager; [
    #   waybar
    # ];

    #     programs.waybar.style = lib.mkAfter ''
    #       * {
    #         border: none;
    #       }
    #       window.main#waybar {
    #         border-bottom: 2px solid @base0D;
    #         border-radius: 0 0 15 15;
    #         padding-right: 2px;
    #         padding-left: 2px;
    #       }
    #       window.side#waybar {
    #         border-bottom: 2px solid @base0D;
    #         border-right: 2px solid @base0D;
    #         border-top: 2px solid @base0D;
    #         border-radius: 0 15 15 0;
    #         padding-top: 2px;
    #         padding-bottom: 2px;
    #       }
    #       window.status#waybar {
    #         border-top: 2px solid @base0D;
    #         border-radius: 15 15 0 0;
    #         padding-right: 2px;
    #         padding-left: 2px;
    #       }
    #       #cpu, #disk, #temperature, #workspaces, #user, #clock, #memory, #pulseaudio, #backlight, #battery, #network {
    #         border-radius: 15px;
    #         margin: 2px;
    #       }
    #       #cpu {
    #         color: @base00;
    #         background-color: @base09;
    #       }
    #       #memory {
    #         color: @base00;
    #         background-color: @base0C;
    #       }
    #       #disk {
    #         color: @base00;
    #         background-color: @base0D;
    #       }
    #       #temperature {
    #         color: @base00;
    #         background-color: @base08;
    #       }
    #       #battery {
    #         color: @base00;
    #         background-color: @base0B;
    #       }
    #       #backlight {
    #         color: @base00;
    #         background-color: @base0A;
    #       }
    #       #pulseaudio {
    #         color: @base00;
    #         background-color: @base0E;
    #       }
    #       #network {
    #         color: @base00;
    #         background-color: @base0D;
    #       }
    #       #workspaces button {
    #         color: @base0D;
    #       }
    #       #workspaces button.hover {
    #         background-color: @base03;
    #       }
    #       #workspaces button.active {
    #         color: @base0B;
    #       }
    #       #custom-notification {
    #         color: @base09;
    #       }
    #       tooltip {
    #         border-radius: 15px;
    #         border: 2px solid @base0D;
    #       }
    #       #clock {
    #         color: @base0D;
    #       }
    #     '';
    programs.waybar.style = lib.mkAfter ''
      * {
        border: none;
      }

      window.status#waybar {
        background-color: alpha(@base00, 0.7);
        border-top: solid alpha(@base04, 0.7) 4;
      }

      window.main#waybar {
        background-color: alpha(@base00, 0.7);
        border-bottom: solid alpha(@base04, 0.7) 4;
      }

      window.side#waybar {
        background-color: alpha(@base00, 0.7);
        border-top: solid alpha(@base04, 0.7) 4;
        border-right: solid alpha(@base04, 0.7) 4;
        border-bottom: solid alpha(@base04, 0.7) 4;
        border-radius: 0 15 15 0;
      }

      window.status .modules-center {
        background-color: alpha(@base01, 0.7);
        color: @base0B;
        border-radius: 15;
        padding-left: 20;
        padding-right: 20;
        margin-top: 5;
        margin-bottom: 5;
      }

      window.status .modules-left {
        background-color: alpha(@base01, 0.7);
        border-radius: 0 15 15 0;
        padding-left: 20;
        padding-right: 20;
        margin-top: 5;
        margin-bottom: 5;
      }

      window.status .modules-right {
        background-color: alpha(@base01, 0.7);
        border-radius: 15 0 0 15;
        padding-left: 20;
        padding-right: 20;
        margin-top: 5;
        margin-bottom: 5;
      }

      #user {
        padding-left: 10;
      }

      #language {
        padding-left: 15;
      }

      #keyboard-state label.locked {
        color: @base0A;
      }

      #keyboard-state label {
        color: @base04;
      }

      #workspaces {
        margin-left: 10;
      }

      #workspaces button {
        color: @base05;
        font-size: 1.25rem;
      }

      #workspaces button.empty {
        color: @base04;
      }

      #workspaces button.active {
        color: @base0D;
      }

      #submap {
        background-color: alpha(@base01, 0.7);
        border-radius: 15;
        padding-left: 15;
        padding-right: 15;
        margin-left: 20;
        margin-right: 20;
        margin-top: 5;
        margin-bottom: 5;
      }

      window.main .modules-center {
        font-weight: bold;
        background-color: alpha(@base01, 0.7);
        color: @base09;
        border-radius: 15;
        padding-left: 20;
        padding-right: 20;
        margin-top: 5;
        margin-bottom: 5;
      }

      #custom-separator {
        color: @base0B;
      }

      #custom-separator_dot {
        color: @base0B;
      }

      #clock.time {
        color: @base09;
      }

      #clock.week {
        color: @base0D;
      }

      #clock.month {
        color: @base0D;
      }

      #clock.calendar {
        color: @base0E;
      }

      #bluetooth {
        background-color: alpha(@base01, 0.7);
        border-radius: 15;
        padding-left: 15;
        padding-right: 15;
        margin-top: 5;
        margin-bottom: 5;
      }

      #bluetooth.disabled {
        background-color: alpha(@base02, 0.7);
        color: @base04;
      }

      #bluetooth.on {
        color: @base0D;
      }

      #bluetooth.connected {
        color: @base0D;
      }

      #network {
        background-color: alpha(@base01, 0.7);
        border-radius: 15;
        padding-left: 15;
        padding-right: 15;
        margin-left: 2;
        margin-right: 2;
        margin-top: 5;
        margin-bottom: 5;
      }

      #network.disabled {
        background-color: alpha(@base02, 0.7);
        color: @base04;
      }

      #network.disconnected {
        color: @base08;
      }

      #network.wifi {
        color: @base0C;
      }

      #idle_inhibitor {
        margin-right: 6;
      }

      #idle_inhibitor.deactivated {
        color: @base04;
      }

      #custom-dunst.off {
        color: @base04;
      }

      #custom-airplane_mode {
        margin-right: 6;
      }

      #custom-airplane_mode.off {
        color: @base04;
      }

      #custom-night_mode {
        margin-right: 6;
      }

      #custom-night_mode.off {
        color: @base04;
      }

      #custom-dunst {
        margin-right: 6;
      }

      #custom-media {
        margin-right: 6;
      }

      #custom-media.Paused {
        color: @base04;
      }

      #custom-webcam {
        color: @base0F;
        margin-right: 6;
      }

      #privacy-item.screenshare {
        color: @base09;
        margin-right: 6;
      }

      #privacy-item.audio-in {
        color: @base0E;
        margin-right: 6;
      }

      #custom-recording {
        color: @base08;
        margin-right: 6;
      }

      #custom-geo {
        color: @base0A;
        margin-right: 6;
      }

      #custom-logout_menu {
        color: @base08;
        background-color: alpha(@base01, 0.7);
        border-radius: 15 0 0 15;
        padding-left: 10;
        padding-right: 5;
        margin-top: 5;
        margin-bottom: 5;
      }

      window.side .modules-center {
        background-color: alpha(@base01, 0.7);
        border-radius: 0 15 15 0;
        margin-right: 5;
        margin-top: 15;
        margin-bottom: 15;
        padding-top: 5;
        padding-bottom: 5;
      }

      #taskbar {
        margin-top: 10;
        margin-right: 10;
        margin-left: 10;
      }

      #taskbar button.active {
        background-color: alpha(@base0C, 0.3);
        border-radius: 10;
      }

      #tray {
        margin-right: 10;
        margin-left: 10;
      }

      #tray>.needs-attention {
        background-color: alpha(@base08, 0.7);
        border-radius: 10;
      }

      #cpu {
        color: @base0D;
      }

      #cpu.low {
        color: @base09;
      }

      #cpu.lower-medium {
        color: @base0A;
      }

      #cpu.medium {
        color: @base09;
      }

      #cpu.upper-medium {
        color: @base0F;
      }

      #cpu.high {
        color: @base08;
      }

      #memory {
        color: @base0D;
      }

      #memory.low {
        color: @base09;
      }

      #memory.lower-medium {
        color: @base0A;
      }

      #memory.medium {
        color: @base09;
      }

      #memory.upper-medium {
        color: @base0F;
      }

      #memory.high {
        color: @base08;
      }

      #disk {
        color: @base0D;
      }

      #disk.low {
        color: @base09;
      }

      #disk.lower-medium {
        color: @base0A;
      }

      #disk.medium {
        color: @base09;
      }

      #disk.upper-medium {
        color: @base0F;
      }

      #disk.high {
        color: @base08;
      }

      #temperature {
        color: @base0B;
      }

      #temperature.critical {
        color: @base08;
      }

      #battery {
        color: @base0C;
      }

      #battery.low {
        color: @base08;
      }

      #battery.lower-medium {
        color: @base0F;
      }

      #battery.medium {
        color: @base09;
      }

      #battery.upper-medium {
        color: @base09;
      }

      #battery.high {
        color: @base09;
      }

      #backlight {
        color: @base03;
      }

      #backlight.low {
        color: @base03;
      }

      #backlight.lower-medium {
        color: @base03;
      }

      #backlight.medium {
        color: @base04;
      }

      #backlight.upper-medium {
        color: @base04;
      }

      #backlight.high {
        color: @base05;
      }

      #pulseaudio.bluetooth {
        color: @base0D;
      }

      #pulseaudio.muted {
        color: @base02;
      }

      #pulseaudio {
        color: @base05;
      }

      #pulseaudio.low {
        color: @base03;
      }

      #pulseaudio.lower-medium {
        color: @base03;
      }

      #pulseaudio.medium {
        color: @base03;
      }

      #pulseaudio.upper-medium {
        color: @base04;
      }

      #pulseaudio.high {
        color: @base04;
      }

      #systemd-failed-units {
        color: @base08;
      }
    '';
  };
}
