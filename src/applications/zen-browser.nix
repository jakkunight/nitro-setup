let
  feature = "zen-browser";
in
{ inputs, ... }:
{
  flake.modules = {
    homeManager.${feature} =
      { pkgs, ... }:
      {
        imports = [
          inputs.zen-browser.homeModules.twilight
        ];
        programs.zen-browser = {
          enable = true;
          profiles."default" = {
            extensions.force = true;
            mods = [
              "642854b5-88b4-4c40-b256-e035532109df"
            ];
          };
        };
      };
  };
}
