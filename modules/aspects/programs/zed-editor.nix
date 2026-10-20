let
  feature = "zed-editor";
in
{ den, ... }:
{
  den.aspects.${feature}.homeManager =
    { pkgs, ... }:
    {
      programs.zed-editor.userSettings = {
        helix_mode = true;
      };
    };
}
