{pkgs, ...}: {
  # Install packages to the "$PATH":
  home.packages = with pkgs; [
    mdformat
    markdown-oxide
  ];
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "tokyonight";
      editor = {
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
