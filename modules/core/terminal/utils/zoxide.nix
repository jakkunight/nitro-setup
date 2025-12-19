_: let
  module = "terminal/utils/zoxide";
in {
  flake.modules = {
    nixos.${module} = {pkgs, ...}: {
      programs.zoxide = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };
      environment.shellAliases = {
        cd = "z";
      };
      environment.systemPackages = with pkgs; [
        zoxide
      ];
    };
    homeManager.${module} = _: {
      programs.zoxide = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };
      home.shellAliases = {
        cd = "z";
      };
    };
  };
}
