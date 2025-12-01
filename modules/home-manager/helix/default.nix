{pkgs, ...}: {
  # Install packages to the "$PATH":
  home.packages = with pkgs; [
    wl-clipboard-rs
  ];
  home.sessionVariables = {
    COPILOT_API_KEY = "ghu_5AzUtyscuXcdssFtmfpPrmXokZmFgU1JWP1k";
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
        scls = {
          command = "${pkgs.simple-completion-language-server}/bin/simple-completion-language-server";
          config = {
            feature_words = false; # enable completion by word
            feature_snippets = true; # enable snippets
            snippets_first = true; # completions will return before snippets by default
            snippets_inline_by_word_tail = false; # suggest snippets by WORD tail, for example text `xsq|` become `x^2|` when snippet `sq` has body `^2`
            feature_unicode_input = false; # enable "unicode input"
            feature_paths = false; # enable path completion
            feature_citations = false; # enable citation completion (only on `citation` feature enabled)
          };
        };
        nixd = {
          command = "${pkgs.nixd}/bin/nixd";
        };
        nil = {
          command = "${pkgs.nil}/bin/nil";
        };
        markdown-oxide = {
          command = "${pkgs.markdown-oxide}/bin/markdown-oxide";
        };
        marksman = {
          command = "${pkgs.marksman}/bin/marksman";
          args = [
            "server"
          ];
        };
        tinymist = {
          command = "${pkgs.tinymist}/bin/tinymist";
        };
        gpt = {
          # command = "${pkgs.helix-gpt}/bin/helix-gpt";
          command = "";
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
        basedpyright = {
          command = "${pkgs.basedpyright}/bin/basedpyright-langserver";
        };

        ruff = {
          command = "${pkgs.ruff}/bin/ruff";
          args = [
            "server"
          ];
        };
        sqruff = {
          command = "${pkgs.sqruff}/bin/sqruff";
          args = ["lsp"];
        };
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "${pkgs.alejandra}/bin/alejandra";
          };
          language-servers = [
            {
              name = "nixd";
            }
            {
              name = "nil";
            }
            {
              name = "scls";
            }
            {
              name = "gpt";
            }
          ];
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
            {
              name = "scls";
            }
            {
              name = "gpt";
            }
          ];
        }
        {
          name = "typst";
          auto-format = true;
          formatter = {
            command = "${pkgs.typstyle}/bin/typstyle";
            args = [
              "-i"
              "-t"
              "4"
            ];
          };
          language-servers = [
            {
              name = "tinymist";
            }
          ];
        }
        {
          name = "rust";
          auto-format = true;
          language-servers = [
            {
              name = "scls";
            }
            {
              name = "rust-analyzer";
            }
            {
              name = "gpt";
            }
          ];
        }
        {
          name = "typescript";
          auto-format = true;
          formatter = {
            command = "";
            args = [];
          };
          language-servers = [
            {
              name = "scls";
            }
            {
              name = "gpt";
            }
          ];
        }
        {
          name = "sql";
          auto-format = true;
          formatter = {
            command = "${pkgs.sqruff}/bin/sqruff";
            args = ["fix" "-"];
          };
          language-servers = [
            {
              name = "sqruff";
            }
            {
              name = "scls";
            }
            {
              name = "gpt";
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
          language-servers = [
            {
              name = "scls";
            }

            {
              name = "qmlls";
            }
            {
              name = "gpt";
            }
          ];
        }
        {
          name = "python";
          auto-format = true;
          language-servers = [
            {
              name = "basedpyright";
            }
            {
              name = "scls";
            }
            {
              name = "ruff";
            }
            {
              name = "gpt";
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
              name = "scls";
            }
            {
              name = "jdtls";
            }
            {
              name = "gpt";
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
