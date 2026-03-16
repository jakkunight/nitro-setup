let
  feature = "stylix-standalone-hm";
in
{ self, ... }:
{
  flake.modules.homeManager.${feature} = {
    imports = [
      self.modules.homeManager.stylix
    ];
  };
}
