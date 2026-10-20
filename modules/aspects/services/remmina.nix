let
  feature = "remmina";
in
{ den, ... }:
{
  den.aspects.${feature}.homeManager = {
    services.remmina = {
      enable = true;
    };
  };
}
