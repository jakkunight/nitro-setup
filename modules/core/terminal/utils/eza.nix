_: let
  module = "terminal/utils/eza";
in {
  flake.modules = {
    nixos.${module} = {pkgs, ...}: {
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
    homeManager.${module} = _: {
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
