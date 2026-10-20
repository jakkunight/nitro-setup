let
  feature = "haveged";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos = {
    services.haveged.enable = true;
  };
}
