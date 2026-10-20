let
  feature = "nightmare-zen-browser";
in
{ den, ... }:
{
  den.aspects.${feature}.homeManager = {
    stylix.targets.zen-browser.profileNames = [
      "default"
    ];
    programs.zen-browser.profiles."default".mods = [
      "642854b5-88b4-4c40-b256-e035532109df" # Transparent Zen Mod
    ];
  };
}
