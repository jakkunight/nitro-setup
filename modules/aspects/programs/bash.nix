let
  feature = "bash";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos = {
      programs.bash = {
        enable = true;
        enableCompletion = true;
        enableLsColors = true;
      };
    };
    homeManager = {
      programs.bash = {
        enable = true;
        enableCompletion = true;
      };
    };
  };

}
