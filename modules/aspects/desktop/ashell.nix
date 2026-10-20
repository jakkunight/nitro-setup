let
  feature = "ashell";
in
{ den, ... }:
{
  den.aspects.${feature}.homeManager =
    { pkgs, ... }:
    {
      programs.ashell = {
        enable = true;
        systemd.enable = true;
      };
    };

}
