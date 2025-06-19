{pkgs, ...}: {
  programs.helix = {
    enable = true;
    package = pkgs.helix;
    settings = {
      # theme = "tokyonight";
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
        marksman = {
          command = "${pkgs.marksman}/bin/marksman";
          args = ["server"];
        };
        markdown-oxide = {
          command = "${pkgs.markdown-oxide}/bin/markdown-oxide";
        };
        qmlls = {
          command = "${pkgs.kdePackages.qtdeclarative}/bin/qmlls";
          formatting = {
            command = ["${pkgs.kdePackages.qtdeclarative}/bin/qmlformat"];
            args = ["-i"];
          };
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
          formatter = {
            command = "${pkgs.mdformat}/bin/mdformat";
            args = ["-"];
          };
          language-servers = ["markdown-oxide" "marksman"];
        }
        {
          name = "qml";
          auto-format = true;
          formatter.command = "${pkgs.libsForQt5.qt5.qtdeclarative}/bin/qmlformat";
          formatter.args = ["-i"];
          language-servers = ["qmlls"];
        }
      ];
    };
  };
}
