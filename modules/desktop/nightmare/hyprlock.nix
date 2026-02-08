_: {
  flake.modules.homeManager."desktop/nightmare/hyprlock" = {
    config,
    lib,
    ...
  }: let
    profile = ./assets/jakku-night-profile.png;
    rgba = color: alpha: "rgba(${color}${alpha})";
    rgb = color: "rgba(${color})";
  in {
    programs.hyprlock = {
      enable = true;
      settings = {
        animations = {
          enabled = true;
          fade_in = {
            duration = 300;
            bezier = "easeOutQuint";
          };
          fade_out = {
            duration = 300;
            bezier = "easeOutQuint";
          };
        };
        # User profile
        image = {
          path = "${profile}";
          size = "130";
          rounding = "-1";
          position = "0, 40";
          halign = "center";
          valign = "center";
        };
        shape = [
          # User box
          {
            xray = "false"; # if true, make a "hole" in the background (rectangle of specified size, no rotation)
            size = "300, 60";
            rounding = "-1";
            color = rgba config.lib.stylix.colors.base00 "70";
            position = "0, -130";
            halign = "center";
            valign = "center";
          }
        ];
        label = [
          # Date
          {
            text = "cmd[update:1000] echo -e \"$(date +\"%A, %B %d\")\"";
            font_color = rgb config.lib.stylix.colors.base06;
            font_size = "25";
            position = "0, 350";
            halign = "center";
            valign = "center";
          }
          # Time
          {
            text = "cmd[update:1000] echo -e \"$(date +\"%I:%M\")\"";
            font_color = rgb config.lib.stylix.colors.base06;
            font_size = "120";
            position = "0, 250";
            halign = "center";
            valign = "center";
          }
          # User label
          {
            text = "    $USER";
            font_color = rgb config.lib.stylix.colors.base06;
            font_size = "18";
            position = "0, -130";
            halign = "center";
            valign = "center";
          }
        ];
        input-field = {
          size = lib.mkForce "300, 60";
          position = lib.mkForce "0, -210";
          halign = "center";
          valign = "center";
        };
      };
    };
  };
}
