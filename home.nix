{
  config,
  inputs,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jakku";
  home.homeDirectory = "/home/jakku";

  # Allow unfree software:
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  programs.git = {
    enable = true;
  };

  # Stylix:
  stylix = {
    enable = true;
    base16Scheme = {
      # scheme = "Tokyonight";
      # author = "Folke Lemaitre (https://github.com/folke)";
      base00 = "1a1b26";
      base01 = "16161e";
      base02 = "2f3549";
      base03 = "444b6a";
      base04 = "787c99";
      base05 = "a9b1d6";
      base06 = "cbccd1";
      base07 = "d5d6db";
      base08 = "c0caf5";
      base09 = "a9b1d6";
      base0A = "0db9d7";
      base0B = "9ece6a";
      base0C = "b4f9f8";
      base0D = "2ac3de";
      base0E = "bb9af7";
      base0F = "f7768e";
    };
    image = ./wallpaper.jpg;
    fonts = {
      serif = {
        package = inputs.genshin-font.packages.${pkgs.system}.default;
        name = "Genshin Impact";
      };

      sansSerif = config.stylix.fonts.serif;

      monospace = {
        package = pkgs.nerd-fonts.hack;
        name = "Hack Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 14;
        terminal = 14;
        desktop = 14;
        popups = 14;
      };
    };
    cursor = {
      package = pkgs.breeze-hacked-cursor-theme;
      name = "Breeze_Hacked";
      size = 36;
    };
    opacity = {
      applications = 1.0;
      terminal = 1.0;
      desktop = 0.8;
      popups = 0.8;
    };
    iconTheme = {
      enable = true;
      package = pkgs.candy-icons;
      dark = "candy-icons";
      light = "candy-icons";
    };
    targets = {
      helix = {
        enable = false;
      };
      waybar.font = "serif";
      firefox.profileNames = [
        "default"
      ];
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "tokyonight";
      editor = {
        line-number = "relative";
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        indent-guides = {
          render = true;
        };
      };
      keys = {};
    };
    languages = {
      language-server = {
        nixd = {
          command = "${pkgs.nixd}/bin/nixd";
        };
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "${pkgs.alejandra}/bin/alejandra";
          };
        }
      ];
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      scan_timeout = 10;
    };
  };

  programs.zellij = {
    enable = true;
  };

  programs.gitui = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "yy";
  };

  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
  };

  programs.wofi = {
    enable = true;
    package = pkgs.wofi;
  };

  programs.waybar = {
    enable = true;
    settings = {
      main-bar = {
        name = "main";
        layer = "top";
        position = "top";
        modules-left = [
          "backlight"
          "backlight/slider"
          "pulseaudio"
          "pulseaudio/slider"
        ];
        modules-center = [
          "tray"
          "hyprland/workspaces"
        ];
        modules-right = [
          "network"
          "cpu"
          "temperature"
          "memory"
          "disk"
          "battery"
          "clock"
          "custom/notification"
        ];
        # Modules:
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
        "backlight/slider" = {
          "min" = 0;
          "max" = 100;
          "orientation" = "horizontal";
          "device" = "intel_backlight";
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
        "pulseaudio/slider" = {
          "min" = 0;
          "max" = 100;
          "orientation" = "horizontal";
        };
        "tray" = {};
        "hyprland/workspaces" = {
          "persistent-workspaces" = {
            "*" = 6;
          };
          "format" = "{icon}";
          "format-icons" = {
            "1" = "󱄅";
            "2" = "󰈹";
            "3" = "󰨡";
            "4" = "󰕼";
            "5" = "󰓓";
            "6" = "";
            "default" = "";
          };
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
              "󰈂"
              "󰈁"
            ];
            "linked" = [
              "󰌚"
            ];
            "disconnected" = [
              "󰌙"
            ];
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
          "format" = " {used}GiB";
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
          "tooltip" = false;
        };
        "custom/notification" = {
          "tooltip" = false;
          "format" = "{icon}";
          "format-icons" = {
            "notification" = "<sup></sup>";
            "none" = "";
            "dnd-notification" = "<sup></sup>";
            "dnd-none" = "";
            "inhibited-notification" = "<sup></sup>";
            "inhibited-none" = "";
            "dnd-inhibited-notification" = "<sup></sup>";
            "dnd-inhibited-none" = "";
          };
          "return-type" = "json";
          "exec-if" = "which swaync-client";
          "exec" = "${pkgs.swaynotificationcenter}/bin/swaync-client -swb";
          "on-click" = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
          "on-click-right" = "${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw";
          "escape" = true;
        };
      };
    };
    style = ''
      #backlight-slider slider {
        opacity: 0;
        border: none;
        box-shadow: none;
        min-height: 0rem;
        min-width: 0rem;
      }
      #backlight-slider trough {
        border-radius: 5px;
        min-height: 0.2rem;
        min-width: 4rem;
      }
      #backlight-slider highlight {
        border-radius: 5px;
        min-width: 4rem;
        min-height: 0.2rem;
      }
      #pulseaudio-slider slider {
        opacity: 0;
        background-image: none;
        border: none;
        box-shadow: none;
        min-height: 0rem;
        min-width: 0rem;
      }
      #pulseaudio-slider trough {
        border-radius: 5px;
        min-width: 4rem;
        min-height: 0.2rem;
      }
      #pulseaudio-slider highlight {
        border-radius: 5px;
        min-width: 4rem;
        min-height: 0.2rem;
      }
      #workspaces button {
        font-size: 2rem;
      }
      #workspaces button.active {
        font-size: 2rem;
      }
    '';
  };

  programs.btop = {
    enable = true;
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      xwayland = {
        force_zero_scaling = true;
      };
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "NVD_BACKEND,direct"
      ];
      monitor = [
        "eDP-1,preferred,auto,1.0"
      ];
      "$mod" = "SUPER";
      input = {
        kb_layout = "latam";
        follow_mouse = 1;
      };
      exec-once = [
        "uwsm app -- systemctl --user start waybar.service"
      ];

      # Cursor:
      cursor = {
        no_hardware_cursors = true;
      };
      # Keybindings
      bindel = [
        # Multimedia:
        ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
        ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
        ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
        ", XF86AudioMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 5%-"
      ];
      binde = [
        # Resize windows with $mod + CTRL + arrow keys
        "$mod CTRL, left, resizeactive, -1% 0%"
        "$mod CTRL, right, resizeactive, 1% 0%"
        "$mod CTRL, up, resizeactive, 0% 1%"
        "$mod CTRL, down, resizeactive, 0% -1%"
        # Resize windows with $mod + CTRL + vim keys
        "$mod CTRL, h, resizeactive, -1% 0%"
        "$mod CTRL, l, resizeactive, 1% 0%"
        "$mod CTRL, k, resizeactive, 0% 1%"
        "$mod CTRL, j, resizeactive, 0%% -1%"
      ];
      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bind = [
        # Applications:
        "$mod, Return, exec, uwsm app -- kitty"
        "$mod, D, exec, uwsm app -- ${pkgs.wofi}/bin/wofi --show drun"
        "$mod, A, exec, uwsm app -- ${pkgs.firefox}/bin/firefox"
        "$mod, S, exec, uwsm app -- ${pkgs.vlc}/bin/vlc"
        "$mod, E, exec, uwsm app -- ${pkgs.nemo-with-extensions}/bin/nemo"
        "$mod SHIFT, S, exec, uwsm app -- ${pkgs.hyprlock}/bin/hyprlock"

        # Controls:
        ", XF86LogOff, exec, uwsm stop"
        "$mod, F, fullscreen"
        "$mod, W, togglefloating"
        "$mod, Q, killactive"
        "$mod SHIFT, Q, exec, uwsm stop -r"

        # Navigation:
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move focus app to workspace:
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        # Move focus with $mod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        # Move focus with $mod + vim keys
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"
        # Move windows with $mod + SHIFT + arrow keys
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"
        # Move windows with $mod + SHIFT + vim keys
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, l, movewindow, r"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, j, movewindow, d"
        # Take a screenshot:
        " , PRINT, exec, uwsm app -- ${pkgs.hyprshot}/bin/hyprshot -m output"
        "SHIFT, PRINT, exec, uwsm app -- ${pkgs.hyprshot}/bin/hyprshot -m region"
      ];
      blurls = [
        "waybar"
        "wofi"
      ];
      # General:
      general = {
        gaps_in = 5;
        gaps_out = 10;
        # "col.inactive_border" = "rgba(3d59a1ff) rgba(41a6b5ff) 45deg";
        # "col.active_border" = "rgba(7dcfffff) rgba(c3e88dff) 45deg";
        border_size = 2;
        resize_on_border = true;
        no_border_on_floating = false;
        layout = "dwindle";
      };
      # Decorations:
      decoration = {
        rounding = 10;
        # Transparency:
        active_opacity = 0.80;
        inactive_opacity = 0.70;
        # Shadow:
        shadow = {
          enabled = true;
          range = 30;
          render_power = 3;
          # color = "rgba(000000AA)";
          # color_inactive = "rgba(00000000)";
          # color = "rgba(7dcfffaa)";
          # color_inactive = "rgba(4fd6beaa)";
        };
        # Blur:
        blur = {
          enabled = true;
          size = 8;
          passes = 2;
          new_optimizations = true;
          ignore_opacity = true;
          xray = true;
          noise = 0;
          vibrancy = 0;
          brightness = 1;
          contrast = 1;
        };
      };
      # Gestures:
      gestures = {
        workspace_swipe = true;
      };
      # Layouts:
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        force_split = 2;
        smart_split = true;
        smart_resizing = true;
      };
      master = {
        new_status = "slave";
      };
    };
  };
  programs.hyprlock = {
    enable = true;
  };
  services = {
    swaync = {
      enable = true;
    };
    hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        # preload = [
        #   "./wallpaper.jpg"
        # ];
        # wallpaper = [
        #   ", ./wallpaper.jpg"
        # ];
      };
    };
    hyprpolkitagent = {
      enable = true;
    };
    hypridle = {
      enable = true;
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
    udiskie = {
      enable = true;
      settings = {
        # workaround for
        # https://github.com/nix-community/home-manager/issues/632
        program_options = {
          # replace with your favorite file manager
          file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
        };
      };
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.steam
    pkgs.heroic
    pkgs.discord
    pkgs.nautilus
    pkgs.vlc
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jakku/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
