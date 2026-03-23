let
  feature = "remmina";
in
{
  flake.modules.homeManager.${feature} = {
    services.remmina = {
      enable = true;
    };
  };
}
