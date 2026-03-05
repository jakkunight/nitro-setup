let
  feature = "devenv";
in
{
  flake.modules = {
    nixos.${feature} =
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
      };
    homeManager.${feature} =
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
      };
  };
}
