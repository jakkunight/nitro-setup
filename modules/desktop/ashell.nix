let
  feature = "ashell";
in
{
  flake.modules = {
    homeManager.${feature} =
      { pkgs, ... }:
      {
        programs.ashell = {
          enable = true;
          systemd.enable = true;
        };
      };
  };
}
