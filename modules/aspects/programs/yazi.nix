let
  feature = "yazi";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos = {
      programs.yazi = {
        enable = true;
      };
    };
    homeManager = {
      programs.yazi = {
        enable = true;
      };
    };
  };

}
