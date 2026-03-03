let
  feature = "eza";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment = {
          systemPackages = with pkgs; [
            eza
          ];
          shellAliases = {
            ls = "eza --icons always -gh";
            ll = "eza --icons always -lgh";
            la = "eza --icons always -lagh";
            tree = "eza --icons always --tree -agh";
          };
        };
      };
    homeManager.${feature} = {
      programs.eza.enable = true;
      home.shellAliases = {
        ls = "eza --icons always -gh";
        ll = "eza --icons always -lgh";
        la = "eza --icons always -lagh";
        tree = "eza --icons always --tree -agh";
      };
    };
  };
}
