let
  feature = "hyprlock";
in
{
  den.aspects.${feature}.homeManager =
    {
      # config,
      # lib,
      den,
      ...
    }:
    # let
    #   profile = ./assets/jakku-night-profile.png;
    #   rgba = color: alpha: "rgba(${color}${alpha})";
    #   rgb = color: "rgba(${color})";
    # in
    {
      programs.hyprlock = {
        enable = true;
      };
    };
}
