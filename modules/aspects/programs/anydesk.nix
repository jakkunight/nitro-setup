let
  feature = "anydesk";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ anydesk ];
    };
}
