let
  feature = "swaync";
in
{ den, ... }:
{
  den.aspects.${feature}.homeManager = {
    services.swaync = {
      enable = true;
    };
  };

}
