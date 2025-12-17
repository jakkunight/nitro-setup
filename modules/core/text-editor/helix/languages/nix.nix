{
  flake.modules.home."text-editor/helix" = {pkgs, ...}: {
    programs.helix.languages = {
      language-server = {
        nixd = {
          command = "${pkgs.nixd}/bin/nixd";
          config = {
            nixpkgs = {
              expr = "import (builtins.getFlake \"/home/jakku/nitro-setup\").inputs.nixpkgs { }";
            };
            options = {
              nixos.expr = "(builtins.getFlake (\" git+file:// \" + toString /home/jakku/nitro-setup)).nixosConfigurations.nitro.options";
              home_manager.expr = "(builtins.getFlake (\" git+file:// \" + toString /home/jakku/nitro-setup)).homeConfigurations.\"jakku@nitro\".options";
            };
          };
        };
        nil = {
          command = "${pkgs.nil}/bin/nil";
        };
        language = [
          {
            name = "nix";
            auto-format = true;
            formatter = {
              command = "${pkgs.alejandra}/bin/alejandra";
            };
            language-servers = [
              {
                name = "nixd";
              }
            ];
          }
        ];
      };
    };
  };
}
