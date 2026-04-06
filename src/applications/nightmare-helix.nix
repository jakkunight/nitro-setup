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
        vscode-json-languageserver
        ruff
        ty
        sqruff
        pyright
        python314Packages.python-lsp-server
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
                "rumdl"
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
              ];
            }
            {
              name = "json";
              auto-format = true;
              formatter = {
                command = "${pkgs.jsonfmt}/bin/jsonfmt";
              };
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
            }
            {
              name = "toml";
              auto-format = true;
              formatter = {
                command = "${pkgs.taplo}/bin/taplo";
                args = [
                  "format"
                  "-"
                ];
              };
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
              ];
            }
            {
              name = "html";
              auto-format = true;
            }
            {
              name = "css";
              auto-format = true;
            }
            {
              name = "javascript";
              auto-format = true;
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
              ];
            }
          ];
        };
      };
    };
}
