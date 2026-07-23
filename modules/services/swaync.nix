let
  feature = "swaync";
in
{
  flake.modules = {
    homeManager.${feature} = {
      services.swaync = {
        enable = true;
      };
    };
  };
}
