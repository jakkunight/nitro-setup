let
  feature = "zed-editor";
in
{
  flake.modules.homeManager.${feature} =
    { pkgs, ... }:
    {
      programs.zed-editor.userSettings = {
        helix_mode = true;
      };
    };
}
