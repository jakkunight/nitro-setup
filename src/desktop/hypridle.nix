let
  feature = "hypridle";
in
{
  flake.modules.homeManager.${feature} =
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
