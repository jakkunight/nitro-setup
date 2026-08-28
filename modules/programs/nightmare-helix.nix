let
  feature = "nightmare-helix";
in
{ self, ... }:
{
  flake.modules.homeManager.${feature} =
    { pkgs, lib, ... }:
    {
      imports = with self.modules.homeManager; [
        helix
      ];
      home.packages = with pkgs; [
        vscode-css-languageserver
        superhtml
        typescript-language-server
        yaml-language-server
        taplo
        tombi
        vscode-json-languageserver
        ruff
        ty
        sqruff
        pyright
        python314Packages.python-lsp-server
        simple-completion-language-server
        markdown-oxide
      ];
      programs.helix = {
        defaultEditor = true;
        settings = {
          editor = {
            bufferline = lib.mkForce "always";
            trim-trailing-whitespace = true;
            trim-final-newlines = true;
            soft-wrap = {
              enable = true;
              wrap-indicator = lib.mkForce "↪";
            };
            inline-diagnostics = {
              cursor-line = "warning";
              other-lines = "hint";
            };
            end-of-line-diagnostics = "hint";
          };
        };
        languages = {
          language-server = {
            scls = {
              command = "${pkgs.simple-completion-language-server}/bin/simple-completion-language-server";
              config = {
                feature_words = true; # enable completion by word
                feature_snippets = true; # enable snippets
                snippets_first = true; # completions will return before snippets by default
                snippets_inline_by_word_tail = false; # suggest snippets by WORD tail, for example text `xsq|` become `x^2|` when snippet `sq` has body `^2`
                feature_unicode_input = true; # enable "unicode input"
                feature_paths = true; # enable path completion
                feature_citations = true; # enable citation completion (only on `citation` feature enabled)
              };
              environment = {
                RUST_LOG = "info,simple-completion-language-server=info";
                LOG_FILE = "/tmp/completion.log";
              };
            };
            # tombi = {
            #   command = "${pkgs.tombi}/bin/tombi";
            #   args = [];
            # };
            taplo = {
              command = "${pkgs.taplo}/bin/taplo";
              args = [
                "lsp"
                "stdio"
              ];
            };
            tinymist = {
              command = "${pkgs.tinymist}/bin/tinymist";
              config = {
                exportPdf = "onSave";
                formatterMode = "typstyle";
                preview = {
                  background.enable = true;
                  background.args = [
                    "--data-plane-host=127.0.0.1:0"
                    "--invert-colors=never"
                    "--open"
                  ];
                };
              };
            };
            jdtls = {
              command = "${pkgs.jdt-language-server}/bin/jdtls";
              args = [
                "-data"
                "~/.cache/jdtls/workspace"
              ];
            };
            ruff = {
              command = "${pkgs.ruff}/bin/ruff";
              args = [
                "server"
              ];
            };
            pylsp = {
              command = "${pkgs.python314Packages.python-lsp-server}/bin/pylsp";
            };
            sqruff = {
              command = "${pkgs.sqruff}/bin/sqruff";
              args = [
                "lsp"
                "--dialect"
                "ansi"
              ];
            };
            pyright = {
              command = "${pkgs.pyright}/bin/pyright";
              args = [
                "-"
              ];
            };
            qmlls = {
              command = "${pkgs.qt6.qtdeclarative}/bin/qmlls";
              args = [ ];
            };
          };
          language = [
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
                "marksman"
                "markdown-oxide"
                "rumdl"
                "scls"
              ];
            }
            {
              name = "nix";
              auto-format = true;
              formatter = {
                command = "${pkgs.nixfmt}/bin/nixfmt";
              };
              language-servers = [
                "nixd"
                "nil"
                "scls"
              ];
            }
            {
              name = "json";
              auto-format = true;
              formatter = {
                command = "${pkgs.jsonfmt}/bin/jsonfmt";
              };
              language-servers = [
                "scls"
              ];
            }
            {
              name = "yaml";
              auto-format = true;
              formatter = {
                command = "${pkgs.yamlfmt}/bin/yamlfmt";
                args = [
                  "-"
                ];
              };
              language-servers = [
                "scls"
              ];
            }
            {
              name = "toml";
              auto-format = true;
              formatter = {
                command = "${pkgs.taplo}/bin/taplo";
                args = [
                  "fmt"
                  "-"
                ];
              };
              language-servers = [
                "tombi"
                "taplo"
                "scls"
              ];
            }
            {
              name = "typst";
              auto-format = true;
              formatter = {
                command = "${pkgs.typstyle}/bin/typstyle";
                args = [
                  "-t"
                  "4"
                ];
              };
              language-servers = [
                "tinymist"
                "scls"
              ];
            }
            {
              name = "html";
              auto-format = true;
              language-servers = [
                "scls"
              ];
            }
            {
              name = "css";
              auto-format = true;
              language-servers = [
                "scls"
              ];
            }
            {
              name = "javascript";
              auto-format = true;
              language-servers = [
                "scls"
              ];
            }
            {
              name = "java";
              auto-format = true;
              formatter = {
                command = "${pkgs.google-java-format}/bin/google-java-format";
                args = [ "-" ];
              };
              language-servers = [
                "jdtls"
                "scls"
              ];
            }
            {
              name = "python";
              auto-format = true;
              formatter = {
                command = "${pkgs.ruff}/bin/ruff";
                args = [
                  "format"
                  "-"
                ];
              };
              language-servers = [
                "ruff"
                # "pyright"
                "pylsp"
                "scls"
              ];
            }
            {
              name = "sql";
              auto-format = true;
              formatter = {
                command = "${pkgs.sqruff}/bin/sqruff";
                args = [
                  "fix"
                  "--dialect"
                  "ansi"
                  "-"
                ];
              };
              language-servers = [
                "sqruff"
                "scls"
              ];
            }
            {
              name = "qml";
              auto-format = true;
              language-servers = [
                "scls"
                "qmlls"
              ];
            }
          ];
        };
      };
    };
}
