{ lib, config, inputs, pkgs, ... }:
{
  options = {};
  config = {
    programs.nvf.settings.vim = {
      languages = {
        enableLSP = true;
        enableTreesitter = true;
        rust = {
          enable = true;
          crates = {
            enable = true;
            codeActions = true;
          };
        };
        nix = {
          enable = true;
          treesitter = {
            enable = true;
          };
          lsp = {
            enable = true;
            server = "nil";
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
        };
      };
    };
  };
}
