let
  feature = "zoxide";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        programs.zoxide = {
          enable = true;
          enableBashIntegration = true;
          enableZshIntegration = true;
          enableFishIntegration = true;
          enableXonshIntegration = true;
        };
        environment.shellAliases = {
          cd = "z";
        };
        environment.systemPackages = with pkgs; [
          zoxide
        ];
      };
    homeManager.${feature} = {
      programs.zoxide = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        enableNushellIntegration = true;
        enableFishIntegration = true;
      };
      home.shellAliases = {
        cd = "z";
      };
    };
  };
}
