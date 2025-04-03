{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  options = {};
  config = {
    programs.nvf.settings.vim = {
      treesitter = {
        autotagHtml = true;
      };
      languages = {
        enableLSP = true;
        enableTreesitter = true;
        enableFormat = true;
        enableExtraDiagnostics = true;
        rust = {
          enable = true;
          crates = {
            enable = true;
            codeActions = true;
          };
        };
        nix = {
          enable = true;
          lsp = {
            enable = true;
            server = "nixd";
          };
          format = {
            enable = true;
            type = "alejandra";
          };
          extraDiagnostics = {
            enable = true;
            types = [
              "statix"
              "deadnix"
            ];
          };
        };
        sql = {
          enable = true;
        };
        clang = {
          enable = true;
        };
        ts = {
          enable = true;
        };
        python = {
          enable = true;
        };
        markdown = {
          enable = true;
        };
        html = {
          enable = true;
          treesitter = {
            enable = true;
            autotagHtml = true;
          };
        };
        css = {
          enable = true;
        };
        nu = {
          enable = true;
        };
      };
    };
  };
}
