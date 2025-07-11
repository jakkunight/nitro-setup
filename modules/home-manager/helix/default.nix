{pkgs, ...}: {
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
            command = "${pkgs.mdformat}/bin/mdformmat";
            args = ["--stdin"];
          };
        }
      ];
    };
  };
  # Disable if the theme option is set into Helix config:
  stylix.targets.helix = {
    enable = false;
  };
}
