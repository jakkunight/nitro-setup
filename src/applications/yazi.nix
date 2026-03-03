let
  feature = "yazi";
in
{
  flake.modules = {
    nixos.${feature} = {
      programs.yazi = {
        enable = true;
      };
    };
    homeManager.${feature} = {
      programs.yazi = {
        enable = true;
      };
    };
  };
}
