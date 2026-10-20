let
  feature = "waybar";
in
{ inputs, lib, ... }:
{
  den.aspects.${feature}.homeManager =
    {
      config,
      pkgs,
      den,
      ...
    }:
    {
      programs = {
        waybar = {
          enable = true;
          # package = inputs.waybar-git.packages.${pkgs.stdenv.hostPlatform.system}.waybar;
          systemd.enable = true;
        };
      };
    };

}
