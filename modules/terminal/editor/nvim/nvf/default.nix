# NVF config:
{ lib, config, pkgs, ... }: {
  imports = [
    ./ui
    ./lsp
    ./langs
    ./keymaps
    ./autocompletion
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
          options = {
            tabstop = 2;
            shiftwidth = 2;
            autoindent = true;
          };
          lineNumberMode = "number";
        };
      };
    };
  };
}
