let
  feature = "zen-browser";
in
{ inputs, ... }:
{
  flake.modules = {
    homeManager.${feature} =
      { pkgs, lib, ... }:
      {
        imports = [
          inputs.zen-browser.homeModules.twilight
        ];
        programs.zen-browser = {
          enable = true;
          profiles."default" = {
            extensions.force = true;
            mods = lib.mkAfter [
              "642854b5-88b4-4c40-b256-e035532109df"
              "f7c71d9a-bce2-420f-ae44-a64bd92975ab"
            ];
          };
        };
      };
  };
}
