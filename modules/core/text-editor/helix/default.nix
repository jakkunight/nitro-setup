{inputs, ...}: {
  flake.modules.nixos."text-editor/helix" = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      helix
      nil
      nixd
      bash-language-server
      marksman
      tinymist
      pandoc
    ];
  };
  flake.modules.homeManager."text-editor/helix" = {pkgs, ...}: {
    # Install packages to the "$PATH":
    home.packages = with pkgs; [
      wl-clipboard-rs
    ];
    home.sessionVariables = {
      COPILOT_API_KEY = "ghu_5AzUtyscuXcdssFtmfpPrmXokZmFgU1JWP1k";
    };
    programs.helix = {
      enable = true;
      defaultEditor = true;
      # package = pkgs.evil-helix;
      settings = {
        # theme = "tokyonight_transparent";
        editor = {
          text-width = 80; # default
          soft-wrap = {
            enable = true;
            wrap-indicator = "";
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
          inline-diagnostics = {
            cursor-line = "warning";
            other-lines = "info";
          };
          end-of-line-diagnostics = "hint";
          indent-guides = {
            render = true;
          };
          clipboard-provider = "wayland";
          gutters = {
            layout = [
              "diagnostics"
              "spacer"
              "line-numbers"
              "spacer"
              "diff"
            ];
          };
        };
        keys = {};
      };
    };
  };
}
