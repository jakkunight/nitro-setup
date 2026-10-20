let
  feature = "zoxide";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
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
    homeManager = {
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
