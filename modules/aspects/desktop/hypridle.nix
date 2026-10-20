let
  feature = "hypridle";
in
{ den, ... }:
{
  den.aspects.${feature}.homeManager =
    { lib, ... }:
    {
      services.hypridle = {
        enable = true;
        settings = {
          listener = {
            timeout = lib.mkDefault 900;
          };
        };
      };
    };
}
