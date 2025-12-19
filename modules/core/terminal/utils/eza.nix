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
          ls = "eza --icons always";
          ll = "eza --icons always -l";
          la = "eza --icons always -la";
          tree = "eza --icons always --tree";
        };
      };
    };
    homeManager.${module} = _: {
      programs.eza.enable = true;
      home.shellAliases = {
        ls = "eza --icons always";
        ll = "eza --icons always -l";
        la = "eza --icons always -la";
        tree = "eza --icons always --tree";
      };
    };
  };
}
