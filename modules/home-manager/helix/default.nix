{pkgs, ...}: {
  # Install packages to the "$PATH":
  home.packages = with pkgs; [
    wl-clipboard-rs
  ];
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
          wrap-indicator = "";
          wrap-at-text-width = true;
        };
        idle-timeout = 0;
        cursorline = true;
        auto-completion = true;
        path-completion = true;
        auto-format = true;
        bufferline = "always";
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
      };
      keys = {};
    };
    languages = {
      language-server = {
        nixd = {
          command = "${pkgs.nixd}/bin/nixd";
        };
        markdown-oxide = {
          command = "${pkgs.markdown-oxide}/bin/markdown-oxide";
        };
        marksman = {
          command = "${pkgs.marksman}/bin/marksman";
        };
        qmlls = {
          command = "${pkgs.kdePackages.qtdeclarative}/bin/qmlls";
          args = [
            "-E"
          ];
        };
        jdtls = {
          command = "${pkgs.jdt-language-server}/bin/jdtls";
          args = [];
        };
        ruff = {
          command = "${pkgs.ruff}/bin/ruff";
          args = [
            "server"
          ];
        };
        ty = {
          command = "${pkgs.ty}/bin/ty";
          args = [
            "server"
          ];
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
        {
          name = "markdown";
          auto-format = true;
          formatter = {
            command = "${pkgs.deno}/bin/deno";
            args = [
              "fmt"
              "-"
              "--ext"
              "md"
            ];
          };
          language-servers = [
            {
              name = "marksman";
            }
            {
              name = "markdown-oxide";
            }
          ];
        }
        {
          name = "qml";
          auto-format = true;
          formatter = {
            command = "${pkgs.kdePackages.qtdeclarative}/bin/qmlformat}";
            args = [
              "-n"
              "-w 4"
            ];
          };
        }
        {
          name = "python";
          auto-format = true;
          language-servers = [
            {
              name = "ruff";
            }
            {
              name = "ty";
            }
          ];
        }
        {
          name = "java";
          auto-format = true;
          formatter = {
            command = "${pkgs.google-java-format}/bin/google-java-format";
            args = [
              "-"
              "-a"
            ];
          };
          language-servers = [
            {
              name = "jdtls";
            }
          ];
        }
      ];
    };
  };
  # Disable if the theme option is set into Helix config:
  stylix.targets.helix = {
    enable = true;
  };
}
