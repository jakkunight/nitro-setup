let
  feature = "nightmare-waybar";
in
{ inputs, self, ... }: {
  flake.modules.homeManager.${feature} = { pkgs, lib, ... }: {
    # imports = with self.modules.homeManager; [
    #   waybar
    # ];

    programs.waybar.style = lib.mkAfter ''
      * {
        border: none;
      }
      window.main#waybar {
        border-bottom: 2px solid @base0D;
        border-radius: 0 0 15 15;
        padding-right: 2px;
        padding-left: 2px;
      }
      window.side#waybar {
        border-bottom: 2px solid @base0D;
        border-right: 2px solid @base0D;
        border-top: 2px solid @base0D;
        border-radius: 0 15 15 0;
        padding-top: 2px;
        padding-bottom: 2px;
      }
      window.status#waybar {
        border-top: 2px solid @base0D;
        border-radius: 15 15 0 0;
        padding-right: 2px;
        padding-left: 2px;
      }
      #cpu, #disk, #temperature, #workspaces, #user, #clock, #memory, #pulseaudio, #backlight, #battery, #network {
        border-radius: 15px;
        margin: 2px;
      }
      #cpu {
        color: @base00;
        background-color: @base09;
      }
      #memory {
        color: @base00;
        background-color: @base0C;
      }
      #disk {
        color: @base00;
        background-color: @base0D;
      }
      #temperature {
        color: @base00;
        background-color: @base08;
      }
      #battery {
        color: @base00;
        background-color: @base0B;
      }
      #backlight {
        color: @base00;
        background-color: @base0A;
      }
      #pulseaudio {
        color: @base00;
        background-color: @base0E;
      }
      #network {
        color: @base00;
        background-color: @base0D;
      }
      #workspaces button {
        color: @base0D;
      }
      #workspaces button.hover {
        background-color: @base03;
      }
      #workspaces button.active {
        color: @base0B;
      }
      #custom-notification {
        color: @base09;
      }
      tooltip {
        border-radius: 15px;
        border: 2px solid @base0D;
      }
      #clock {
        color: @base0D;
      }
    '';
  };
}
