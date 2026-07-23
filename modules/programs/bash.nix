let
  feature = "bash";
in
{
  flake.modules = {
    nixos.${feature} = {
      programs.bash = {
        enable = true;
        enableCompletion = true;
        enableLsColors = true;
      };
    };
    homeManager.${feature} = {
      programs.bash = {
        enable = true;
        enableCompletion = true;
      };
    };
  };
}
