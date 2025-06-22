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
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
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
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    profiles = {};
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      xwayland = {
        force_zero_scaling = true;
      };
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
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
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
        "$mod, D, exec, uwsm app -- wofi --show drun"
        "$mod, A, exec, uwsm app -- firefox"

        # Controls:
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
      ];
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
