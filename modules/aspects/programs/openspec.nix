let
  feature = "openspec";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          openspec
        ];
      };
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          openspec
        ];
      };
  };

}
