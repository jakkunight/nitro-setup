let
  feature = "nightmare-ashell";
in
{ den, ... }:
{
  den.aspects.${feature}.homeManager =
    { lib, config, ... }:
    let
      inherit (config.lib.stylix.colors.withHashtag)
        base00
        base01
        base05
        base08
        base09
        base0A
        base0B
        base0C
        base0D
        base0E
        base0F
        ;
    in
    {
      programs.ashell.settings = {
        modules = {
          left = [
            "SystemInfo"
            "MediaPlayer"
          ];
          center = [
            "Workspaces"
          ];
          right = [
            "Tray"
            [
              "Clock"
              "Privacy"
              "Settings"
            ]
          ];
        };
        appearance = lib.mkAfter {
          style = "Islands";
          scale_factor = 1.3;
          font_name = lib.mkForce "${config.stylix.fonts.monospace.name}";
          workspace_colors = lib.mkForce [
            base0D
            base0C
            base0E
          ];
        };
      };
    };
}
