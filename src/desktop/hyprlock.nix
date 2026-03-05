let
  feature = "hyprlock";
in
{
  flake.modules.homeManager.${feature} =
    {
      config,
      lib,
      ...
    }:
    let
      profile = ./assets/jakku-night-profile.png;
      rgba = color: alpha: "rgba(${color}${alpha})";
      rgb = color: "rgba(${color})";
    in
    {
      programs.hyprlock = {
        enable = true;
      };
    };
}
