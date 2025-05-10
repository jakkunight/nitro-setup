{pkgs, ...}: {
  programs.nvf.settings.vim = {
    extraPackages = [
      pkgs.arduino-language-server
    ];
    lsp.servers = {
      arduino = {
        enable = true;
        cmd = "arduino_language_server";
        filetypes = ["arduino"];
        capabilities = {
          textDocument = {
            semanticTokens = false;
          };
          workspace = {
            semanticTokens = false;
          };
        };
      };
    };
  };
}
