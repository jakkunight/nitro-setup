let
  moduleName = "core";
in
  {inputs, ...}: {
    flake.nixosModules.${moduleName} = {pkgs, ...}: {
      imports = [
        inputs.determinate.nixosModules.default
      ];
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
      ];
    };
  }
