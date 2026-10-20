let
  feature = "nightmare-hypridle";
in
{ den, ... }:
{
  den.aspects.${feature}.homeManager =
    { pkgs, ... }:
    {
      services.hypridle.settings = {
        general = {
          lock_cmd = "${pkgs.hyprlock}/bin/hyprlock";
        };
        listener = {
          timeout = 900;
          "on-timeout" = "${pkgs.hyprlock}/bin/hyprlock";
        };
      };
    };
}
