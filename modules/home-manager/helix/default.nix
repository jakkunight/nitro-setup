{pkgs, ...}: {
  # Install packages to the "$PATH":
  home.packages = with pkgs; [
    mdformat
    markdown-oxide
  ];
  programs.helix = {
    enable = true;
    defaultEditor = true;
    themes = {
      tokyonight_transparent = {
        inherits = "tokyonight";
        "ui.background" = {};
        "ui.bufferline.background" = {};
        "ui.cursorline.primary" = {};
        "ui.cursorline.secondary" = {};
        "ui.cursorcolumn.primary" = {};
        "ui.cursorcolumn.secondary" = {};
      };
    };
    settings = {
      theme = "tokyonight_transparent";
      editor = {
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
            command = "${pkgs.mdformat}/bin/mdformat";
            args = [
              "-"
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
      ];
    };
  };
  # Disable if the theme option is set into Helix config:
  stylix.targets.helix = {
    enable = false;
  };
}
