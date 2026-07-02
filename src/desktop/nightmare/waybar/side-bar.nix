let
  feature = "nightmare-waybar";
in
{ inputs, self, ... }: {
  flake.modules.homeManager.${feature} = { pkgs, lib, ... }: {
    programs.waybar.settings = lib.mkAfter [
      {
        name = "side";
        layer = "top";
        position = "left";
        width = 72;
        spacing = 8;
        margin-top = 4;
        margin-bottom = 4;
        modules-left = [
          "wlr/taskbar"
        ];
        modules-center = [
        ];
        modules-right = [
        ];
        "wlr/taskbar" = {
          "format" = "{icon}";
          "icon-size" = 20;
          "tooltip-format" = "{title}";
          "on-click" = "activate";
        };
      }
    ];
  };
}
