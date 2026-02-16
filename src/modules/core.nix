let
  moduleName = "core";
in
  {inputs, config, ...}: {
    flake.nixosModules.${moduleName} = {pkgs, ...}: {
      programs = {
        git.enable = true;
        nh = {
          enable = true;
          clean = {
            enable = true;
            extraArgs = "--keep 5 --keep-since 3d";
          };
        };
        starship = {
          enable = true;
          settings = {
            add_newline = true;
            scan_timeout = 10;
          };
        };
        zoxide = {
          enable = true;
          enableBashIntegration = true;
          enableZshIntegration = true;
        };
        yazi = {
          enable = true;
          plugins = {
            inherit (pkgs.yaziPlugins) git sudo glow rsync gitui chmod dupes restore projects compress mount mediainfo toggle-pane smart-paste wl-clipboard full-border;
          };
          settings = {
            keymap = {
              mgr.prepend_keymap = [
                {
                  run = "plugin mount";
                  on = "M";
                }
              ];
            };
          };
        };
      };
      environment.shellAliases = {
        cd = "z";
        ls = "eza --icons always -gh";
        ll = "eza --icons always -lgh";
        la = "eza --icons always -lagh";
        tree = "eza --icons always --tree -agh";
      };
      environment.systemPackages = with pkgs; [
        gitui
        helix
        nixd
        bash-language-server
        marksman
        typst
        tinymist
        zellij
        btop
        mprocs
        (uutils-coreutils.override {prefix = "";})
        ripgrep
        ripgrep-all
        fd
        xh
        dua
        dust
        fselect
        delta
        eza
        clock-rs
        cava
        fastfetch
        pipes-rs
        speedtest-rs
        presenterm
        chafa
        clamav
        vulnix
        bluetuith
      ];
    };
    flake.homeModules.${moduleName} = {
      pkgs,
      ...
    }: {
      services.mpd = {
        enable = true;
        musicDirectory = "${config.home.homeDirectory}/Music";
        playlistDirectory = "${config.home.homeDirectory}/Music/Playlists";
        extraConfig = ''
          audio_output {
            type "pipewire"
            name "My PipeWire Output"
          }
        '';
        network.startWhenNeeded = true;
      };
      home.packages = with pkgs; [
        mpd
        mpv
        puddletag
        yt-dlp
        youtube-tui # This one is a MUST
        ffmpeg # Used to play my music and videos ad hoc.
        ani-cli # Also a MUST
        matugen
        wl-clipboard-rs
      ];
      programs.yazi = {
        enable = true;
        package = pkgs.yazi;
        plugins = {
          inherit (pkgs.yaziPlugins) git sudo glow rsync gitui chmod dupes restore projects compress mount mediainfo toggle-pane smart-paste wl-clipboard full-border;
        };
        keymap = {
          mgr.prepend_keymap = [
            {
              run = "plugin mount";
              on = "M";
            }
          ];
        };
      };
      programs.rmpc = {
        enable = true;
        package = pkgs.rmpc;
        config = ''
          (
            address: "/run/user/${config.home.uid}/mpd/socket",
            cache_dir: Some("${config.home.homeDirectory}/.cache/rmpc"),
          )
        '';
      };
      programs.zellij = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          pane_frames = false;
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
      programs.btop = {
        enable = true;
      };
      programs.bat = {
        enable = true;
      };
      home.shellAliases = {
        cat = "bat";
      };
      programs.eza.enable = true;
      home.shellAliases = {
        ls = "eza --icons always -gh";
        ll = "eza --icons always -lgh";
        la = "eza --icons always -lagh";
        tree = "eza --icons always --tree -agh";
      };
      programs.zoxide = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };
      home.shellAliases = {
        cd = "z";
      };
      programs.kitty = {
        enable = true;
      };
      programs.helix = {
        enable = true;
        defaultEditor = true;
        # package = pkgs.evil-helix;
        settings = {
          # theme = "tokyonight_transparent";
          editor = {
            text-width = 80; # default
            soft-wrap = {
              enable = true;
              wrap-indicator = "󰁕";
              wrap-at-text-width = true;
            };
            idle-timeout = 0;
            cursorline = true;
            auto-completion = true;
            path-completion = true;
            auto-format = true;
            bufferline = "multiple";
            line-number = "relative";
            lsp = {
              snippets = true;
              display-progress-messages = true;
              display-messages = true;
              display-inlay-hints = true;
            };
            inline-diagnostics = {
              cursor-line = "warning";
              other-lines = "info";
            };
            end-of-line-diagnostics = "hint";
            indent-guides = {
              render = true;
            };
            clipboard-provider = "wayland";
            gutters = {
              layout = [
                "diagnostics"
                "spacer"
                "line-numbers"
                "spacer"
                "diff"
              ];
            };
            statusline = {
              left = ["spinner" "mode" "version-control"];
              center = ["file-name" "read-only-indicator" "file-modification-indicator"];
              right = ["diagnostics" "selections" "register" "position" "file-encoding"];
              separator = "";
              mode = {
                normal = "NORMAL";
                insert = "INSERT";
                select = "SELECT";
              };
            };
          };
          keys = {};
        };
      };
    };
  }
