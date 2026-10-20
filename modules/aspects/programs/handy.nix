let
  feature = "handy";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ handy ];
    };
}
