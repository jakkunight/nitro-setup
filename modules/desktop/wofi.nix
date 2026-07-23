let
  feature = "wofi";
in
{
  flake.modules.homeManager.${feature} = {
    programs.wofi = {
      enable = true;
    };
  };
}
