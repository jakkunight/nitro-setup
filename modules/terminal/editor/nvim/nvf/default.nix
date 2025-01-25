# NVF config:
{ lib, config, pkgs, inputs, ... }: {
  imports = [
    inputs.nvf.nixosModules.default
  ];
  options = {
    terminal.editor.nvim.nvf = {
      enable = lib.mkEnableOption "Use NVF as your Neovim flavor.";
    };
  };
  config = lib.mkIf config.terminal.editor.nvim.nvf.enable {
programs.nvf = {
      enable = true;
      settings = {
        vim = {
          viAlias = true;
          vimAlias = true;
          package = pkgs.neovim-unwrapped;
          theme = {
            enable = true;
            name = "tokyonight";
            style = "night";
          };
          statusline = {
            lualine = {
              enable = true;
              theme = "tokyonight";
            };
          };
          telescope = {
            enable = true;
          };
          autocomplete = {
            nvim-cmp = {
              enable = true;
            };
          };
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
          lsp = {
            enable = true;
          };
          filetree = {
            neo-tree = {
              enable = true;
            };
          };
        };
      };
    };
  };
}
