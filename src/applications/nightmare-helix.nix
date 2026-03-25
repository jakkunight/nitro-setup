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
            sqruff = {
              command = "${pkgs.sqruff}/bin/sqruff";
              args = [
                "lsp"
                "--dialect"
                "ansi"
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
                  "-i"
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
