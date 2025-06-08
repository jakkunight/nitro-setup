{
  config,
  lib,
  ...
}: {
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
          server = "nixd";
          options = {
            nixos = {
              expr = "(builtins.getFlake \"/home/jakku/nitro-setup\").nixosConfigurations.nitro.options";
            };
            # home-manager = {
            #   expr = "(builtins.getFlake \"/home/jakku/nitro-setup\").homeConfigurations.\"jakku@nitro\".options";
            # };
          };
        };
        format = {
          type = "alejandra";
        };
        extraDiagnostics = {
          types = [
            "statix"
            "deadnix"
          ];
        };
      };

      sql.enable = true;

      clang.enable = true;

      ts.enable = true;

      python.enable = true;

      java.enable = true;

      markdown.enable = true;

      html = {
        enable = true;
      };

      css.enable = true;

      nu.enable = true;
      tailwind.enable = true;
      svelte.enable = true;
    };
  };
}
