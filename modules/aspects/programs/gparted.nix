let
  feature = "gparted";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ gparted ];
    };
}
