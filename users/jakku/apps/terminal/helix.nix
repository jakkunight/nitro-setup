{pkgs, ...}: {
  programs.helix = {
    enable = true;
    package = pkgs.helix;
    settings = {
      theme = "tokyonight";
      editor = {
        line-number = "relative";
      };
    };
    languages = {
      language-server = {
        nixd = {
          command = "${pkgs.nixd}/bin/nixd";
          formatting = {
            command = ["${pkgs.alejandra}/bin/alejandra"];
          };
          nixpkgs.expr = "import (builtins.getFlake \"/home/jakku/nitro-setup\").inputs.nixpkgs";
          options.nixos = "(builtins.getFlake \"/home/jakku/nitro-setup\").nixosConfigurations.nitro.options";
        };
        rust-analyzer = {
          command = "${pkgs.rust-analyzer-unwrapped}/bin/rust-analyzer";
        };
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.alejandra}/bin/alejandra";
          language-servers = ["nixd" "nil-ls"];
        }
        {
          name = "rust";
          auto-format = true;
          formatter.command = "${pkgs.rustfmt}/bin/rustfmt";
        }
        {
          name = "markdown";
          auto-format = true;
          language-servers = ["ltex-ls" "marksman"];
        }
      ];
    };
  };
}
