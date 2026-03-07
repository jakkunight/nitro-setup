let
  feature = "helix";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          helix
          nixd
          nixfmt
          bash-language-server
          rumdl
          deno
          marksman
          vscode-json-languageserver
          ron-lsp
          yaml-language-server
          tinymist
          taplo
          pandoc
          typst
          wl-clipboard-rs
          xclip
        ];
      };
    homeManager.${feature} =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          helix
          nixd
          nixfmt
          bash-language-server
          rumdl
          vscode-json-languageserver
          ron-lsp
          yaml-language-server
          tinymist
          taplo
          pandoc
          typst
          wl-clipboard-rs
          xclip
        ];
        programs.helix = {
          enable = true;
          defaultEditor = true;
          settings = {
            # theme = "tokyonight_transparent";
            editor = {
              text-width = 80; # default
              soft-wrap = {
                enable = true;
                wrap-indicator = "󰁕";
                wrap-at-text-width = true;
              };
              idle-timeout = 0;
              cursorline = true;
              auto-completion = true;
              path-completion = true;
              auto-format = true;
              bufferline = "multiple";
              line-number = "relative";
              lsp = {
                snippets = true;
                display-progress-messages = true;
                display-messages = true;
                display-inlay-hints = true;
              };
              indent-guides = {
                render = true;
              };
              # clipboard-provider = "wayland";
            };
            keys = { };
          };
        };
      };
  };
}
