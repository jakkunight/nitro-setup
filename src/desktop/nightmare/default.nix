let
  feature = "nightmare-desktop";
in
{
  self,
  inputs,
  ...
}:
{
  flake.modules = {
    nixos.${feature} =
      {
        pkgs,
        lib,
        config,
        ...
      }:
      {
        imports = with self.modules.nixos; [
          hyprland
          hyprland-nvidia
          kitty
          foot
        ];

      };
    homeManager.${feature} =
      {
        pkgs,
        lib,
        config,
        ...
      }:
      {
        imports = with self.modules.homeManager; [
          nightmare-hyprland
          kitty
          foot
          zen-browser
          nightmare-waybar
          hyprwall
          swaync
          # ashell
          hyprlock
          hypridle
          zsh
          nushell
          qutebrowser
          remmina
          wofi
        ];

        programs.zsh.initContent = lib.mkOrder 1200 ''
          clear
          ${pkgs.fastfetch}/bin/fastfetch
          echo "Welcome back, $USER! (^.^)"
        '';

        services.hypridle = {
          settings = {
            general = {
              lock_cmd = "${pkgs.hyprlock}/bin/hyprlock";
            };
            listener = {
              timeout = 900;
              "on-timeout" = "${pkgs.hyprlock}/bin/hyprlock";
            };
          };
        };

        programs.hyprlock =
          let
            profile = "${config.home.homeDirectory}/.face";
            rgba = color: alpha: "rgba(${color}${alpha})";
            rgb = color: "rgba(${color})";
          in
          {
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

        programs.ashell.settings =
          let
            inherit (config.lib.stylix.colors.withHashtag)
              base00
              base01
              base05
              base08
              base09
              base0A
              base0B
              base0C
              base0D
              base0E
              base0F
              ;
          in
          {
            modules = {
              left = [
                "SystemInfo"
                "MediaPlayer"
              ];
              center = [
                "Workspaces"
              ];
              right = [
                "Tray"
                [
                  "Clock"
                  "Privacy"
                  "Settings"
                ]
              ];
            };
            appearance = lib.mkAfter {
              style = "Islands";
              scale_factor = 1.3;
              font_name = lib.mkForce "${config.stylix.fonts.monospace.name}";
              workspace_colors = lib.mkForce [
                base0D
                base0C
                base0E
              ];
            };
          };
        programs.wofi = {
          settings = {
            allow_images = true;
          };
          style = lib.mkAfter ''
            * {
              background: transparent;
            }

            #window {
              margin: auto;
              padding: 10px;
            }

            #input {
              padding: 10px;
              margin-bottom: 10px;
            }

            #outer-box {
              padding: 20px;
            }

            #img {
              margin-right: 6px;
            }

            #entry {
              padding: 10px;
            }

            #text {
              margin: 2px;
            }
          '';

        };
        # stylix.targets.waybar = {
        #   font = "serif";
        # };
        stylix.targets.zen-browser.profileNames = [
          "default"
        ];
        programs.zen-browser.profiles."default" = {
          mods = [
            "642854b5-88b4-4c40-b256-e035532109df" # Transparent Zen Mod
          ];
        };
      };
  };
}
