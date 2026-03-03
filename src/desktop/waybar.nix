let
  feature = "waybar";
in
{ lib, ... }:
{
  flake.modules = {
    homeManager.${feature} =
      {
        config,
        pkgs,
        ...
      }:
      {
        programs.waybar.enable = true;
        programs.waybar.systemd.enable = true;
      };
  };
}
