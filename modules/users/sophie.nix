let
  user = "sophie";
  importAspect = import ../_lib/aspect-class.nix;
in
{ den, ... }:
{
  den.aspects.${user} = {
    nixos.imports = map (importAspect "nixos") [
      den.aspects."${user}-account"
      den.aspects."${user}-os"
    ];
    homeManager.imports = map (importAspect "homeManager") [
      den.aspects."${user}-home"
    ];
  };

  den.homes.x86_64-linux.${user} = {
    includes = [
      den.aspects.stylix-standalone-hm
      den.aspects.standalone-home
    ];
  };
}
