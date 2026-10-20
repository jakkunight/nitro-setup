let
  feature = "wtype";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ wtype ];
    };
}
