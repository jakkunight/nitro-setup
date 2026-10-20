let
  feature = "devenv";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          devenv
        ];
        programs.direnv = {
          enable = true;
          enableBashIntegration = true;
          enableFishIntegration = true;
          enableXonshIntegration = true;
          enableZshIntegration = true;
        };
        nix.extraOptions = ''
          extra-substituters = https://devenv.cachix.org
          extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
        '';
      };
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          devenv
        ];
        programs.direnv = {
          enable = true;
          enableBashIntegration = true;
          enableFishIntegration = true;
          enableNushellIntegration = true;
          enableZshIntegration = true;
          nix-direnv.enable = true;
        };
        nix.extraOptions = ''
          extra-substituters = https://devenv.cachix.org
          extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
        '';
      };
  };

}
