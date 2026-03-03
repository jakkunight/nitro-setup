let
  feature = "gaming";
in
{ self, ... }:
{
  flake.modules = {
    nixos.${feature} = {
      imports = with self.modules.nixos; [
        steam
        heroic
        discord
      ];
    };
    homeManager.${feature} = {
      imports = with self.modules.homeManager; [
        steam
        heroic
        discord
      ];
    };
  };
}
