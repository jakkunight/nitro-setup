let
  feature = "stylix-standalone-hm";
in
{ self, den, ... }:
{
  den.aspects.${feature}.homeManager = {
    imports = [
      den.aspects.stylix.homeManager
    ];
  };
}
