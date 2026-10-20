let
  feature = "wofi";
in
{ den, ... }:
{
  den.aspects.${feature}.homeManager = {
    programs.wofi = {
      enable = true;
    };
  };
}
