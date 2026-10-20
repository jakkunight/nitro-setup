let
  feature = "nightmare-kitty";
in
{ den, ... }:
{
  den.aspects.${feature}.homeManager =
    { lib, config, ... }:
    {
      programs.kitty = {
        font.package = lib.mkForce config.stylix.fonts.monospace.package;
        font.name = lib.mkForce "family=\"${config.stylix.fonts.monospace.name}\"";
      };
    };
}
