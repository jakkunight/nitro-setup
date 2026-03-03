let
  feature = "zellij";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          zellij
        ];
      };
    homeManager.${feature} = {
      programs.zellij = {
        enable = true;
        enableZshIntegration = false;
        enableBashIntegration = false;
        enableFishIntegration = false;
        settings = {
          pane_frames = false;
        };
      };
    };
  };
}
