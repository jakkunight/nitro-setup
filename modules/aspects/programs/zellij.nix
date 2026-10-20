let
  feature = "zellij";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          zellij
        ];
      };
    homeManager = {
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
