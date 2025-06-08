_: {
  imports = [
    ./arduino.nix
  ];
  programs.nvf.settings.vim.languages = {
    enableFormat = true;
    enableTreesitter = true;
    enableExtraDiagnostics = true;

    # For Nix users:
    nix = {
      enable = true;
      lsp.server = "nixd";
    };

    # For every Linux user:
    markdown.enable = true;
    bash.enable = true;

    # Web dev:
    html = {
      enable = true;
      treesitter.autotagHtml = true;
    };
    css.enable = true;
    ts.enable = true;
    tailwind.enable = true;
    svelte.enable = true;
    astro.enable = true;
    # SQL:
    sql.enable = true;

    # Rust:
    rust = {
      enable = true;
      crates = {
        enable = true;
        codeActions = true;
      };
      nu.enable = true;
    };

    # Python:
    python.enable = true;
  };
}
